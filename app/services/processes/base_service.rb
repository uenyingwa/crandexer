# frozen_string_literal: true

module Processes
  class BaseService < ApplicationService
    def call
      packages = fetch_packages

      ActiveRecord::Base.transaction do
        packages.each do |package|
          pkg = extract_description_info(package)
          pkg_attrs = parse_description_info(pkg)

          index_package(pkg_attrs)
        end
      end
      Rails.logger.info "***** [#{self.class.name}][#{__method__}] Done indexing packages! *****"
    rescue StandardError => e
      Rails.logger.error "##### [#{self.class.name}][#{__method__}][Error] No package was indexed: #{e} #####"
    end

    private

    def fetch_packages
      PackagesFetcherService.call
    end

    def extract_description_info(package)
      PackageInfoExtractorService.call(package)
    end

    def parse_description_info(description)
      DescriptionParserService.call(description)
    end

    def index_package(attrs)
      pkg = Package.find_or_initialize_by(name: attrs[:name], version: attrs[:version]) do |package|
        package.author = attrs[:author]
        package.description = attrs[:description]
        package.maintainer = attrs[:maintainer]
        package.published_at = attrs[:published_at]
        package.title = attrs[:title]
      end

      if pkg.save
        Rails.logger.info "***** [#{self.class.name}][#{__method__}] [Package: #{pkg.name}, Version: #{pkg.version} indexed *****"
      else
        Rails.logger.error "##### [#{self.class.name}][#{__method__}][Error] #{pkg.errors.full_messages} #####"
      end
    end
  end
end

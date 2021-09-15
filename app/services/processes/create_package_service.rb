# frozen_string_literal: true

module Processes
  class CreatePackageService < BaseService
    private

    def index_package(attrs)
      pkg = Package.new(attrs)

      if pkg.save
        Rails.logger.info "***** [#{self.class.name}][#{__method__}] [Package: #{pkg.name}, Version: #{pkg.version} indexed *****"
      else
        Rails.logger.error "##### [#{self.class.name}][#{__method__}][Error] #{pkg.errors.full_messages} #####"
      end
    end
  end
end

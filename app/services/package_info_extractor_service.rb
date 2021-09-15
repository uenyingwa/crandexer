# frozen_string_literal: true

require 'rubygems/package'
require 'zlib'

class PackageInfoExtractorError < StandardError; end

class PackageInfoExtractorService < ApplicationService
  attr_reader :package

  include HTTParty

  base_uri BASE_URI

  def initialize(package)
    @package = package
  end

  def call
    r_package = fetch_package
    files = untar(unzip(r_package))
    extract_description_info(files)
  rescue StandardError => e
    Rails.logger.error "##### [#{self.class.name}][#{__method__}][Error] #{e} #####"
  end

  private

  def fetch_package
    file_name = "#{package['Package']}_#{package['Version']}.tar.gz"
    Rails.logger.info "***** [#{self.class.name}][#{__method__}] Fetching #{file_name} *****"

    response = self.class.get("/#{file_name}")
    raise PackageInfoExtractorError, response unless response.success?

    Rails.logger.info "***** [#{self.class.name}][#{__method__}] Done fetching package *****"
    response.body
  end

  def unzip(io)
    Zlib::GzipReader.new(StringIO.new(io))
  end

  def untar(tar_file)
    Gem::Package::TarReader.new(tar_file)
  end

  def extract_description_info(files)
    Rails.logger.info "***** [#{self.class.name}][#{__method__}] Started extracting description info *****"
    description_info = false

    files.each do |file|
      next unless file.full_name.end_with?('DESCRIPTION')

      break description_info = Dcf.parse(file.read.force_encoding('UTF-8'))&.first
    end
    Rails.logger.info "***** [#{self.class.name}][#{__method__}] Done extracting description info *****"
    description_info
  end
end

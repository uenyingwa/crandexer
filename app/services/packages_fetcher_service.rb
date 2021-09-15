# frozen_string_literal: true

class PackagesFetcherError < StandardError; end

class PackagesFetcherService < ApplicationService
  MAX_NO_OF_PACKAGES = 100

  include HTTParty

  base_uri BASE_URI

  def call
    Rails.logger.info "***** [#{self.class.name}][#{__method__}] Fetching packages from cran *****"
    response = self.class.get('/PACKAGES')
    raise PackagesFetcherError, response unless response.success?

    pkgs = response.body.lines('', chomp: true).first(MAX_NO_OF_PACKAGES)
    packages = []

    pkgs.each do |pkg|
      packages << Dcf.parse(pkg)&.first
    end
    packages
  rescue StandardError => e
    Rails.logger.error "##### [#{self.class.name}][#{__method__}][Error] #{e} #####"
  end
end

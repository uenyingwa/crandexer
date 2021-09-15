# frozen_string_literal: true

class UpdatePackageWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.info '----------> Updating packages'

    Processes::UpdatePackageService.call
  end
end

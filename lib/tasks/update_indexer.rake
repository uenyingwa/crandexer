# frozen_string_literal: true

namespace :update do
  desc 'Index cran packages'
  task packages: :environment do
    UpdatePackageWorker.perform_async
  end
end

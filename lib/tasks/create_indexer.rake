# frozen_string_literal: true

namespace :create do
  desc 'Index cran packages'
  task packages: :environment do
    Processes::CreatePackageService.call
  end
end

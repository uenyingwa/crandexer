# frozen_string_literal: true

require 'dcf'

class ApplicationService
  BASE_URI = 'https://cran.r-project.org/src/contrib'

  def self.call(*args, &block)
    new(*args, &block).call
  end
end

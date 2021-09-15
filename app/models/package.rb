# frozen_string_literal: true

class Package < ApplicationRecord
  validates :name, :version, presence: true
  validates :version, uniqueness: {
    scope: :name,
    message: 'for this package already exists!'
  }
end

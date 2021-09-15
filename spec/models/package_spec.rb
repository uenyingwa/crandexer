# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Package, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:version) }
  end
end

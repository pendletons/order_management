require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validation" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price }

    it { is_expected.to validate_uniqueness_of :name }
  end
end

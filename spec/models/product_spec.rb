require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validation" do
    subject { build(:product) }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :price }

    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(0) }
  end
end

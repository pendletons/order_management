require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe "validations" do
    it { is_expected.to validate_presence_of :order_date }
    it { is_expected.to validate_presence_of :vat_amount }

    it { is_expected.to validate_numericality_of(:vat_amount).is_greater_than_or_equal_to(0) }
  end

end

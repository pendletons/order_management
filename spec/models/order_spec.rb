require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe "validations" do
    it { is_expected.to validate_numericality_of(:vat_amount).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { is_expected.to have_many(:line_items) }
    it { is_expected.to have_many(:products).through(:line_items) }
  end

  describe "defaults" do
    let(:order) { Order.new }

    subject { order }

    before { order.save }

    it "defaults order_date to today" do
      expect(order.order_date).to eq Date.current
    end

    it "defaults VAT to Order::VAT_AMOUNT" do
      expect(order.vat_amount).to eq Order::VAT_AMOUNT
    end
  end
end

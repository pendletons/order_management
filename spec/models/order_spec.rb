require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe "validations" do
    it { is_expected.to validate_numericality_of(:vat_amount).is_greater_than_or_equal_to(0) }

    describe "updating" do
      let(:order) { create(:order) }

      context "when order can be changed" do
        it "is valid" do
          order.order_date = Date.current + 5.days
          expect(order.valid?).to be true
        end
      end

      context "when order cannot be changed" do
        let!(:line_item) { create(:line_item, order: order) }

        before { order.transition_to!(:placed) }

        it "is invalid" do
          order.order_date = Date.current + 5.days
          expect(order.valid?).to be false
        end
      end
    end
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

  describe "#net_total" do
    let(:order) { create(:order) }
    let(:product1) { create(:product) }
    let(:product2) { create(:product, name: "Widget 2", price: 100) }
    let!(:line_item1) { create(:line_item, order: order, product: product1) }
    let!(:line_item2) { create(:line_item, order: order, product: product2) }

    subject { order.net_total }

    it "calculates the total of line item amounts" do
      expect(subject).to eq 2200
    end
  end

  describe "#gross_total" do
    let(:order) { create(:order) }
    let(:product1) { create(:product) }
    let(:product2) { create(:product, name: "Widget 2", price: 100) }
    let!(:line_item1) { create(:line_item, order: order, product: product1) }
    let!(:line_item2) { create(:line_item, order: order, product: product2) }

    subject { order.gross_total }

    it "calculates the total of line item amounts with VAT included" do
      expect(subject).to eq 2640
    end
  end

  describe "#destroy" do
    let(:order) { create(:order) }

    subject { order }

    before { order.destroy }

    it "does not delete the order" do
      expect(subject.destroyed?).to be false
    end
  end
end

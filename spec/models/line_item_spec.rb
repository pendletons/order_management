require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :order }
    it { is_expected.to validate_presence_of :product }
    it { is_expected.to validate_presence_of :quantity }

    it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
  end

  describe "associations" do
    it { is_expected.to belong_to :order }
    it { is_expected.to belong_to :product }
  end

  describe "#product_name" do
    let(:line_item) { build_stubbed(:line_item) }

    subject { line_item.product_name }

    it "delegates to product" do
      expect(line_item.product).to receive(:name)
      subject
    end
  end

  describe "#product_price" do
    let(:line_item) { build_stubbed(:line_item) }

    subject { line_item.product_price }

    it "delegates to product" do
      expect(line_item.product).to receive(:price)
      subject
    end
  end

  describe "#total" do
    let(:product) { create(:product) }
    let(:line_item) { create(:line_item, product: product) }

    subject { line_item.total }

    it "calculates quantity * product price" do
      expect(subject).to eq 2000
    end
  end
end

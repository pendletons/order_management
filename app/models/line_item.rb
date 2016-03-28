class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates_presence_of :order, :product, :quantity
  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  validate :order_is_draft?, on: :update

  delegate :name, :price, to: :product, prefix: true
  delegate :can_be_changed?, to: :order

  def total
    (product_price * quantity).to_f
  end

  private

    def order_is_draft?
      unless can_be_changed?
        errors[:base] << "Cannot change placed orders."
        return false
      end
    end
end

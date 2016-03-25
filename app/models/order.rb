class Order < ActiveRecord::Base
  VAT_AMOUNT = 1.20

  validates_presence_of :order_date, :vat_amount
  validates_numericality_of :vat_amount, greater_than_or_equal_to: 0

  before_validation :set_default_order_date, :set_vat_amount

  private

    def set_default_order_date
      self[:order_date] ||= Date.current
      self[:order_date] = Date.current if order_date < Date.current
      nil
    end

    def set_vat_amount
      # cache this in case VAT changes in the future
      self[:vat_amount] ||= VAT_AMOUNT
      nil
    end
end

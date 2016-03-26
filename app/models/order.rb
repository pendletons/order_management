class Order < ActiveRecord::Base
  VAT_AMOUNT = 1.20

  has_many :line_items
  has_many :products, through: :line_items

  validates_presence_of :order_date, :vat_amount
  validates_numericality_of :vat_amount, greater_than_or_equal_to: 0

  validates :order_date, date: { after_or_equal_to: Proc.new { Date.current } }

  before_validation :set_default_order_date, :set_vat_amount

  def net_total
    line_items.inject(0) { |sum, li| sum + li.total }
  end

  def gross_total
    net_total * VAT_AMOUNT
  end

  private

    def set_default_order_date
      self[:order_date] ||= Date.current
      self[:order_date] = Date.current if past_order_date?
      nil
    end

    def set_vat_amount
      # cache this in case VAT changes in the future
      self[:vat_amount] ||= VAT_AMOUNT
      nil
    end

    def past_order_date?
      order_date.is_a?(Date) && order_date < Date.current
    end
end

class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates_presence_of :order, :product, :quantity
  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  delegate :name, to: :product, prefix: true
end

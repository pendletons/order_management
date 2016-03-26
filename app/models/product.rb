class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items

  validates_presence_of :name, :price
  validates_uniqueness_of :name
  validates_numericality_of :price, only_integer: true, greater_than_or_equal_to: 0

  before_destroy :verify_no_orders

  private

    def verify_no_orders
      unless orders.empty?
        errors[:base] << "Cannot delete a product that has been ordered."
        return false
      end
    end
end

class Product < ActiveRecord::Base
  validates_presence_of :name, :price
  validates_uniqueness_of :name
  validates_numericality_of :price, only_integer: true, greater_than_or_equal_to: 0

  before_destroy :verify_no_orders

  def orders
    []
  end

  private

    def verify_no_orders
      unless orders.empty?
        errors[:base] << "Cannot delete a product that has been ordered."
        return false
      end
    end
end

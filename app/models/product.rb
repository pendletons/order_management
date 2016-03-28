class Product < ActiveRecord::Base
  validates_presence_of :name, :price
  validates_uniqueness_of :name
  validates_numericality_of :price, only_integer: true, greater_than_or_equal_to: 0
end

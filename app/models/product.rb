class Product < ActiveRecord::Base
  validates_presence_of :name, :price
  validates_uniqueness_of :name
end

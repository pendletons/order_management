require 'ffaker'

FactoryGirl.define do
  factory :product do
    name { FFaker::Product.product }
    price 1000
  end
end

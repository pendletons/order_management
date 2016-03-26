FactoryGirl.define do
  factory :line_item do
    association(:order)
    association(:product)
    quantity 2
  end
end

FactoryGirl.define do
  factory :order do
    order_date { Date.current }

    trait :order_tomorrow do
      order_date { Date.current + 1.day }
    end

    trait :order_yesterday do
      order_date { Date.current - 1.day }
    end
  end
end

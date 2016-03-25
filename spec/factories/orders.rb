FactoryGirl.define do
  factory :order do
    vat_amount { Order::VAT_AMOUNT }

    trait :order_today do
      order_date { Date.current }
    end

    trait :order_tomorrow do
      order_date { Date.current + 1.day }
    end

    trait :order_yesterday do
      order_date { Date.current - 1.day }
    end
  end
end

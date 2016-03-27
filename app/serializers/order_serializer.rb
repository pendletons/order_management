class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_date, :net_total, :gross_total
end

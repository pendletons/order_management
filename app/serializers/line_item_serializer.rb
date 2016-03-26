class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :product_id, :quantity, :product_name
end

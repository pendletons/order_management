Given(/^a product exists$/) do
  @product = create(:product)
end

When(/^an order does exist for that product$/) do
  @line_item = create(:line_item, product_id: @product.id)
end

Then(/^attempt to delete the product$/) do
  @product.destroy
end

Then(/^the product is not deletable$/) do
  step "attempt to delete the product"
  expect(@product.destroyed?).to be false
end

When(/^an order does not exist for that product$/) do
  # product has no orders by default
end

Then(/^the product is deletable$/) do
  step "attempt to delete the product"
  expect(@product.destroyed?).to be true
end

When(/^valid product information is provided$/) do
  @attr = attributes_for(:product)
end

Then(/^a product will be created$/) do
  expect { Product.create! @attr }.not_to raise_error
end

When(/^valid product update information is provided$/) do
  @attr = attributes_for(:product).merge(price: 2500)
end

Then(/^the product will be updated$/) do
  expect { @product.update! @attr }.not_to raise_error
end

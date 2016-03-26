When(/^a line item is created with a valid order id$/) do
  step "valid line item information is provided"
  step "a line item will be created"
end

Then(/^the line item is valid$/) do
  expect(@line_item.valid?).to be true
end

When(/^a line item is created without a valid order id$/) do
  step "valid line item information is provided"
  @line_item.order_id = nil
end

Then(/^the line item is invalid$/) do
  expect(@line_item.valid?).to be false
end

When(/^a line item is created with a valid product id$/) do
  step "valid line item information is provided"
  step "a line item will be created"
end

When(/^a line item is created without a valid product id$/) do
  step "valid line item information is provided"
  @line_item.product_id = nil
end

Given(/^a line item exists$/) do
  @line_item = create(:line_item)
end

Then(/^it is invalid$/) do
  expect(@line_item.valid?).to be false
end

Then(/^it is valid$/) do
  expect(@line_item.valid?).to be true
end

When(/^its quantity is (-?\d+)$/) do |quantity|
  @line_item.quantity = quantity
end

When(/^valid line item information is provided$/) do
  @attr = attributes_for(:line_item)
  @attr[:order_id] = @order.id if @order
  @attr[:product_id] = @product.id if @product
  @line_item = build(:line_item, @attr)
end

Then(/^a line item will be created$/) do
  expect { LineItem.create!(@attr) }.not_to raise_error
end

When(/^valid line item update information is provided$/) do
  @attr = attributes_for(:line_item).merge(quantity: 20)
end

Then(/^the line item will be updated$/) do
  expect { @line_item.update!(@attr) }.not_to raise_error
end

When(/^the line item is deleted$/) do
  expect { @line_item.destroy! }.not_to raise_error
end

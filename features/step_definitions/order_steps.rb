When(/^valid order information is provided$/) do
  @attr = attributes_for(:order)
end

Then(/^an order will be created$/) do
  expect { Order.create! @attr }.not_to raise_error
end

Given(/^an order exists$/) do
  @order = create(:order)
end

When(/^valid order update information is provided$/) do
  @attr = attributes_for(:order, :order_tomorrow)
end

Then(/^the order will be updated$/) do
  expect { @order.update! @attr }.not_to raise_error
end

Then(/^the order cannot be deleted$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^no order date is specified$/) do
  @attr = attributes_for(:order)
end

Then(/^the order date is today$/) do
  @date = Date.current
  step "the order date is the specified date"
end

When(/^an order date is specified in the future$/) do
  @attr = attributes_for(:order, :order_tomorrow)
  @date = @attr[:order_date]
end

Then(/^the order date is the specified date$/) do
  expect(Order.create(@attr).order_date).to eq @date
end

When(/^an order date is specified in the past$/) do
  @attr = attributes_for(:order, :order_yesterday)
end

Then(/^the order VAT amount is (\d+)%$/) do |percent|
  vat_percent = (Order.create(@attr).vat_amount - 1) * 100 # convert to whole number
  expect(vat_percent).to eq percent.to_f
end

Then(/^a reason is required$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

When(/^it has (\d+) line items$/) do |count|
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^it cannot proceed to placed state$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^it can proceed to placed state$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

When(/^it is in (.*) state$/) do |state|
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the order and its line items can be changed$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the order and its line items cannot be changed$/) do
    pending # Write code here that turns the phrase above into concrete actions
end

When(/^an order is created$/) do
  @order = create(:order)
end

Then(/^a reason is not required$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^it can be moved to (.*) state$/) do |state|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^the order has a line item$/) do
  @line_item = create(:line_item, order_id: @order.id)
end

Then(/^the order has no line items$/) do
  # orders have no line items by default
end

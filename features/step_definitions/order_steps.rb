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
  @order.destroy
  expect(@order.destroyed?).to be false
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
  # no reason set on the order
  expect { @order.transition_to!(@new_state) }.to raise_error Statesman::GuardFailedError
  @order.cancellation_reason = "I feel like it"
  expect { @order.transition_to!(@new_state) }.not_to raise_error
end

When(/^it has (\d+) line items$/) do |count|
  create_list(:line_item, count.to_i, order: @order)
end

Then(/^it cannot proceed to placed state$/) do
  expect { @order.transition_to!(:placed) }.to raise_error Statesman::GuardFailedError
end

Then(/^it can proceed to placed state$/) do
  expect { @order.transition_to!(:placed) }.not_to raise_error
end

When(/^a line item is created$/) do
  create(:line_item, order: @order)
end

When(/^it is in (.*) state$/) do |state|
  case state
  when "cancelled"
    @order.cancellation_reason = "just because"
    @order.transition_to!(:cancelled)
  when "placed"
    step "a line item is created"
    @order.transition_to!(:placed)
  when "paid"
    step "a line item is created"
    @order.transition_to!(:placed)
    @order.transition_to!(:paid)
  when "draft"
    expect(@order.current_state).to eq "draft"
  else
    raise "Unknown state"
  end
end

Then(/^the order and its line items can be changed$/) do
  @order.order_date = Date.current + 5.days
  expect(@order.valid?).to be true
  line_item = @order.line_items.first || create(:line_item, order: @order)
  line_item.quantity = 25
  expect(line_item.valid?).to be true
end

Then(/^the order and its line items cannot be changed$/) do
  @order.order_date = Date.current + 5.days
  expect(@order.valid?).to be false
  line_item = @order.line_items.first || create(:line_item, order: @order)
  line_item.quantity = 25
  expect(line_item.valid?).to be false
end

When(/^an order is created$/) do
  @order = create(:order)
end

Then(/^a reason is not required$/) do
  expect { @order.transition_to!(@new_state) }.not_to raise_error
end

Then(/^it can be moved to (.*) state$/) do |state|
  @new_state = state
  create(:line_item, order: @order) if @new_state == "placed"
end

Given(/^the order has a line item$/) do
  @line_item = create(:line_item, order_id: @order.id)
end

Then(/^the order has no line items$/) do
  # orders have no line items by default
end

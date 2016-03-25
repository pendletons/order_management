Given(/^a product exists$/) do
  @product = create(:product)
end

When(/^an order does exist for that product$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the product is not deletable$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^an order does not exist for that product$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the product is deletable$/) do
  pending # Write code here that turns the phrase above into concrete actions
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

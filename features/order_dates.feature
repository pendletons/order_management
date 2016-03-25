Feature: Order Dates
  Order dates can be customised, but not a past value

  Scenario: Default order date
    Given valid order information is provided
    When no order date is specified
    Then the order date is today

  Scenario: Valid future order date
    Given valid order information is provided
    When an order date is specified in the future
    Then the order date is the specified date

  Scenario: Invalid past order date
    Given valid order information is provided
    When an order date is specified in the past
    Then the order date is today

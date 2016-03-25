Feature: Line Item Management
  Line items can be added, edited or deleted

  Scenario: Line item creation
    Given an order exists
    When valid line item information is provided
    Then a line item will be created

  Scenario: Line item updating
    Given an order exists
    When valid line item update information is provided
    Then the line item will be updated

  Scenario: Line item deleting
    Given an order exists
    And the order has a line item
    When the line item is deleted
    Then the order has no line items

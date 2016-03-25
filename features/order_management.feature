Feature: Order Management
  Orders can be added or edited but not deleted

  Scenario: Order creation
    When valid order information is provided
    Then an order will be created

  Scenario: Order updating
    Given an order exists
    When valid order update information is provided
    Then the order will be updated

  Scenario: Order deleting
    Given an order exists
    Then the order cannot be deleted

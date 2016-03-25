Feature: Order VAT

  Scenario: Default VAT value
    Given valid order information is provided
    Then the order VAT amount is 20%

Feature: Line items
  Line items belong to an order, reference a product, and have a positive quantity

  Scenario Outline: Line items and orders
    Given an order exists
    And a product exists
    When a line item is created <with_or_without_order?> a valid order id
    Then the line item is <valid_or_not_valid?>

    Examples:
      | with_or_without_order? | valid_or_not_valid? |
      | with                   | valid               |
      | without                | invalid             |

  Scenario Outline: Line items and products
    Given a product exists
    And an order exists
    When a line item is created <with_or_without_product?> a valid product id
    Then the line item is <valid_or_not_valid?>

    Examples:
      | with_or_without_product? | valid_or_not_valid? |
      | with                     | valid               |
      | without                  | invalid             |

  Scenario Outline: Line item quantities
    Given a line item exists
    When its quantity is <quantity>
    Then it is <valid_or_not_valid?>

    Examples:
      | quantity | valid_or_not_valid? |
      | -2       | invalid             |
      | -1       | invalid             |
      | 0        | invalid             |
      | 1        | valid               |
      | 100      | valid               |

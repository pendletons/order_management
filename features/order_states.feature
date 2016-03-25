Feature: Order state flow
  Orders progress through the following states: draft, placed, paid, cancelled

  Scenario: Default order state
    When an order is created
    Then it is in draft state

  Scenario Outline: Order workflow
    Given an order exists
    And it is in <current_state> state
    Then it can be moved to <new_state> state
    And a reason is <reason_is_or_is_not_required?>

    Examples:
      | current_state | new_state | reason_is_or_is_not_required? |
      | draft         | placed    | not required                  |
      | placed        | paid      | not required                  |
      | draft         | cancelled | required                      |
      | placed        | cancelled | required                      |

  Scenario Outline: Orders and line items
    Given an order exists
    When it has <line_items> line items
    Then it <can_or_cannot_be_placed?> proceed to placed state

    Examples:
      | line_items | can_or_cannot_be_placed? |
      | 0          | cannot                   |
      | 1          | can                      |
      | 2          | can                      |

  Scenario Outline: Changing orders
    Given an order exists
    When it is in <current_state> state
    Then the order and its line items <can_or_cannot_be_changed?>

    Examples:
      | current_state | can_or_cannot_be_changed? |
      | draft         | can be changed            |
      | placed        | cannot be changed         |
      | paid          | cannot be changed         |
      | cancelled     | cannot be changed         |

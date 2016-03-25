Feature: Product management
  Products can be added or edited
  Products cannot be deleted if they have orders

  Scenario: Product creation
    When valid product information is provided
    Then a product will be created

  Scenario: Product updating
    Given a product exists
    When valid product update information is provided
    Then the product will be updated

  Scenario Outline: Products deleting
    Given a product exists
    When an order <order_exists_or_not?> for that product
    Then the product is <deletable_or_not?>

    Examples:
      | order_exists_or_not? | deletable_or_not? |
      | does exist           | not deletable     |
      | does not exist       | deletable         |

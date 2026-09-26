Feature: Order validation against available cash (BR-05)

  Background:
    Given account ACC-100001 is ACTIVE
    And the account has a cash balance of 1000.00 GBP

  Scenario: Buy order within available cash is accepted
    When the client submits a BUY order for 5 VOD at 80.00
    Then the order is recorded with status NEW
    And the client sees the order in the blotter

  Scenario: Buy order above available cash is rejected
    When the client submits a BUY order for 20 VOD at 80.00
    Then the order is recorded with status REJECTED
    And the client sees the reason "Insufficient cash"
    And the cash balance remains 1000.00 GBP

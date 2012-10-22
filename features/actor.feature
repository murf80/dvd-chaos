Feature: Actor tests
  Actor tests.

  Scenario: Create new actor
    Given the following actor exists:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
    When I go to the actors page
    Then I should see "Alan Alda"

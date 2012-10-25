Feature: Actor tests
  Actor tests.

  Scenario: Create new actor
    Given the following actor exists:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
    When I go to the actors page
    Then I should see actor "Alan Alda"

  Scenario: Create actor with missing info
    When I add an actor with no gender
    Then The actor should be invalid due to missing gender

  Scenario: Create duplicate actor
    Given the following actor exists:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
    When I add a duplicate actor  with name "Alan Alda" and gender "female"
    Then The actor should be invalid

  Scenario: Create actor through the ui
    Given I am on the new actor page
    And I fill in actor "Name" with "Alan Alda"
    And I fill in actor date of birth with month "January", day "28", and year "1936"
    And I fill in actor "Gender" with "male"
    When I press actor button "Create Actor"
    Then I should see actor message "Actor was successfully created."
    And I should see actor date of birth "01-28-1936"
    When I go to the actors index page
    Then I should see actor date of birth "01-28-1936"

  Scenario: Update date of birth on an actor
    Given I am on the new actor page
    And I fill in actor "Name" with "Alan Alda"
    And I fill in actor date of birth with month "January", day "28", and year "1936"
    And I fill in actor "Gender" with "male"
    When I press actor button "Create Actor"
    Then I should see actor message "Actor was successfully created."
    And I should see actor date of birth "01-28-1936"
    When I follow actor link "Edit"
    And I fill in actor date of birth with month "March", day "28", and year "1936"
    When I press actor button "Update Actor"
    Then I should see actor message "Actor was successfully updated."
    And I should see actor date of birth "03-28-1936"

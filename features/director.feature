Feature: Director tests
  Director tests.

  Scenario: Create new director
    Given the following director exists:
      | Name      | Gender | dob        |
      | Robert Altman | male   | 02-20-1925 |
    When I go to the directors page
    Then I should see director "Robert Altman"

  Scenario: Create director with missing info
    When I add an director with no gender
    Then The director should be invalid due to missing gender

  Scenario: Create duplicate director
    Given the following director exists:
      | Name      | Gender | dob        |
      | Robert Altman | male   | 02-20-1925 |
    When I add a duplicate director  with name "Robert Altman" and gender "female"
    Then The director should be invalid

  Scenario: Create director through the ui
    Given I am on the new director page
    And I fill in director "Name" with "Robert Altman"
    And I fill in director date of birth with month "January", day "28", and year "1936"
    And I fill in director "Gender" with "male"
    When I press director button "Create Director"
    Then I should see director message "Director was successfully created."
    And I should see director date of birth "01-28-1936"
    When I go to the directors index page
    Then I should see director date of birth "01-28-1936"

  Scenario: Update date of birth on an director
    Given I am on the new director page
    And I fill in director "Name" with "Robert Altman"
    And I fill in director date of birth with month "January", day "28", and year "1936"
    And I fill in director "Gender" with "male"
    When I press director button "Create Director"
    Then I should see director message "Director was successfully created."
    And I should see director date of birth "01-28-1936"
    When I follow director link "Edit"
    And I fill in director date of birth with month "March", day "28", and year "1936"
    When I press director button "Update Director"
    Then I should see director message "Director was successfully updated."
    And I should see director date of birth "03-28-1936"

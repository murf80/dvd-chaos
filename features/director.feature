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
    Given I am on the new "directors" page
    And I fill in "Name" with "Robert Altman"
    And I fill in date with month "January", day "28", and year "1936"
    And I choose "director_gender_male"
    When I press button "Create Director"
    Then I should see message "Director was successfully created."
    And I should see date "01-28-1936"
    When I go to the "directors" index page
    Then I should see date "01-28-1936"

  Scenario: Update date of birth on an director
    Given I am on the new "directors" page
    And I fill in "Name" with "Robert Altman"
    And I fill in date with month "January", day "28", and year "1936"
    And I choose "director_gender_male"
    When I press button "Create Director"
    Then I should see message "Director was successfully created."
    And I should see date "01-28-1936"
    When I follow link "Edit"
    And I fill in date with month "March", day "28", and year "1936"
    When I press button "Update Director"
    Then I should see message "Director was successfully updated."
    And I should see date "03-28-1936"

  Scenario: Ensure users can delete directors from the view page
    Given the following director exists:
      | Name      | Gender | dob        |
      | Robert Altman | male   | 02-20-1925 |
    And I am on the view page for director "Robert Altman"
    When I follow link "Destroy"
    Then The director "Robert Altman" should be destroyed

  Scenario: Ensure users can delete directors from the index page
    Given the following director exists:
      | Name      | Gender | dob        |
      | Robert Altman | male   | 02-20-1925 |
    And I go to the "directors" index page
    When I follow link "Destroy"
    Then The director "Robert Altman" should be destroyed

  Scenario: Create director through the ui with dvds
    Given the following dvd exists:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
    Given I am on the new "directors" page
    And I fill in "Name" with "Alan Alda"
    And I fill in date with month "January", day "28", and year "1936"
    And I choose "director_gender_male"
    And I select "M*A*S*H" for the dvd name
    When I press button "Create Director"
    Then I should see message "Director was successfully created."
    And I should see date "01-28-1936"
    When I am on the view page for director "Alan Alda"
    Then I should see date "01-28-1936"
    And I should see dvd name is "M*A*S*H"

  Scenario: Update director dvds through the ui
    Given the following dvds exist:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
      | RAD | RAD (1986)   |
    Given I am on the new "directors" page
    And I fill in "Name" with "Alan Alda"
    And I fill in date with month "January", day "28", and year "1936"
    And I choose "director_gender_male"
    And I select "M*A*S*H" for the dvd name
    When I press button "Create Director"
    Then I should see message "Director was successfully created."
    When I follow link "Edit"
    And I select "RAD" for the dvd name
    When I press button "Update Director"
    Then I should see message "Director was successfully updated."
    When I am on the view page for director "Alan Alda"
    And I should see dvd name is "RAD"

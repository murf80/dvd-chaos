Feature: Dvd tests
  Dvd tests.

  Scenario: Create dvd with missing info
    When I add an dvd with no summary
    Then The dvd should be invalid due to missing summary

  Scenario: Create duplicate dvd
    Given the following dvd exists:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
    When I add a duplicate dvd  with name "M*A*S*H" and summary "M*A*S*H (1973)"
    Then The dvd should be invalid

   Scenario: Create dvd through the ui with no director or actors
     Given I am on the new "dvds" page
     And I fill in "Name" with "Rocky"
     And I fill in date with month "January", day "28", and year "1976"
     And I fill in "Summary" with "Rocky is cool"
     And I fill in "Asin" with "B000059H99"
     When I press button "Create Dvd"
     Then I should see message "Dvd was successfully created."
     And I should see date "01-28-1976"
     And I should see dvd asin link for "B000059H99"
     When I go to the "dvds" index page
     Then I should see date "01-28-1976"

  Scenario: Create dvd through the ui with no director, actors, or asin
    Given I am on the new "dvds" page
    And I fill in "Name" with "Rocky"
    And I fill in date with month "January", day "28", and year "1976"
    And I fill in "Summary" with "Rocky is cool"
    When I press button "Create Dvd"
    Then I should see message "Dvd was successfully created."
    And I should see date "01-28-1976"
    And I should not see dvd asin link for "B000059H99"

  Scenario: Ensure users can delete DVDs from the view page
    Given the following dvd exists:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
    And I am on the view page for the "M*A*S*H" dvd
    When I follow link "Destroy"
    Then The "M*A*S*H" dvd should be destroyed

  Scenario: Create dvd through the ui with director and no actors
    Given the following directors exists:
      | Name      | Gender | dob        |
      | Robert Altman | male   | 01-28-1963 |
      | Burt Metcalf | male   | 04-10-1915 |
    And I am on the new "dvds" page
    Then I should see 2 directors available for the dvd
    Given I fill in "Name" with "M*A*S*H"
    And I fill in date with month "January", day "28", and year "1976"
    And I fill in "Summary" with "M*A*S*H rocks"
    And I select "Robert Altman" for the dvd director
    When I press button "Create Dvd"
    Then I should see message "Dvd was successfully created."
    And I should not see dvd asin link for "B000059H99"
    And I should see date "01-28-1976"
    And I should see the dvd director is "Robert Altman"

  Scenario: Create dvd through the ui with director and actors
    Given the following directors exists:
      | Name      | Gender | dob        |
      | Robert Altman | male   | 01-28-1963 |
      | Burt Metcalf | male   | 04-10-1915 |
    Given the following actors exist:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
      | Mike Farrel | male   | 04-10-1915 |
    And I am on the new "dvds" page
    Then I should see 2 directors available for the dvd
    And I should see 2 actors available for the dvd
    Given I fill in "Name" with "M*A*S*H"
    And I fill in date with month "January", day "28", and year "1976"
    And I fill in "Summary" with "M*A*S*H rocks"
    And I select "Robert Altman" for the dvd director
    And I select "Alan Alda" for the dvd actor
    When I press button "Create Dvd"
    Then I should see message "Dvd was successfully created."
    And I should not see dvd asin link for "B000059H99"
    And I should see the dvd director is "Robert Altman"
    And I should see the dvd actor is "Alan Alda"
    And I should see date "01-28-1976"

  Scenario: Update actors on a dvd
    Given the following actors exist:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
      | Mike Farrel | male   | 04-10-1915 |
    And I am on the new "dvds" page
    Given I fill in "Name" with "M*A*S*H"
    And I fill in date with month "January", day "28", and year "1976"
    And I fill in "Summary" with "M*A*S*H rocks"
    And I select "Alan Alda" for the dvd actor
    When I press button "Create Dvd"
    Then I should see message "Dvd was successfully created."
    And I should see the dvd actor is "Alan Alda"
    And I should see date "01-28-1976"
    When I follow link "Edit"
    And I select "Mike Farrel" for the dvd actor
    When I press button "Update Dvd"
    Then I should see message "Dvd was successfully updated."
    And I should see the dvd actor is "Mike Farrel"

  Scenario: Update release date on a dvd
    And I am on the new "dvds" page
    Given I fill in "Name" with "M*A*S*H"
    And I fill in date with month "January", day "28", and year "1976"
    And I fill in "Summary" with "M*A*S*H rocks"
    When I press button "Create Dvd"
    Then I should see message "Dvd was successfully created."
    And I should see date "01-28-1976"
    When I follow link "Edit"
    And I fill in date with month "March", day "28", and year "1976"
    When I press button "Update Dvd"
    Then I should see message "Dvd was successfully updated."
    And I should see date "03-28-1976"





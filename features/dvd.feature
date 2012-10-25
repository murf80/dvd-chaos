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
     Given I am on the new dvd page
     And I fill in dvd "Name" with "Rocky"
     And I fill in dvd "Release date" with "01-28-1976"
     And I fill in dvd "Summary" with "Rocky is cool"
     And I fill in dvd "Asin" with "B000059H99"
     When I press dvd button "Create Dvd"
     Then I should see dvd message "Dvd was successfully created."
     And I should see dvd asin link for "B000059H99"

  Scenario: Create dvd through the ui with no director, actors, or asin
    Given I am on the new dvd page
    And I fill in dvd "Name" with "Rocky"
    And I fill in dvd "Release date" with "01-28-1976"
    And I fill in dvd "Summary" with "Rocky is cool"
    When I press dvd button "Create Dvd"
    Then I should see dvd message "Dvd was successfully created."
    And I should not see dvd asin link for "B000059H99"

  Scenario: Ensure users can delete DVDs from the view page
    Given the following dvd exists:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
    And I am on the view page for the "M*A*S*H" dvd
    When I follow dvd link "Destroy" and confirm it
    Then The "M*A*S*H" dvd should be destroyed

  Scenario: Create dvd through the ui with director and no actors
    Given the following directors exists:
      | Name      | Gender | dob        |
      | Robert Altman | male   | 01-28-1963 |
      | Burt Metcalf | male   | 04-10-1915 |
    And I am on the new dvd page
    Then I should see 2 directors available for the dvd
    Given I fill in dvd "Name" with "M*A*S*H"
    And I fill in dvd "Release date" with "01-28-1976"
    And I fill in dvd "Summary" with "M*A*S*H rocks"
    And I select "Robert Altman" for the dvd director
    When I press dvd button "Create Dvd"
    Then I should see dvd message "Dvd was successfully created."
    And I should not see dvd asin link for "B000059H99"
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
    And I am on the new dvd page
    Then I should see 2 directors available for the dvd
    And I should see 2 actors available for the dvd
    Given I fill in dvd "Name" with "M*A*S*H"
    And I fill in dvd "Release date" with "01-28-1976"
    And I fill in dvd "Summary" with "M*A*S*H rocks"
    And I select "Robert Altman" for the dvd director
    And I select "Alan Alda" for the dvd actor
    When I press dvd button "Create Dvd"
    Then I should see dvd message "Dvd was successfully created."
    And I should not see dvd asin link for "B000059H99"
    And I should see the dvd director is "Robert Altman"
    And I should see the dvd actor is "Alan Alda"

  Scenario: Update actors on a dvd
    Given the following actors exist:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
      | Mike Farrel | male   | 04-10-1915 |
    And I am on the new dvd page
    Given I fill in dvd "Name" with "M*A*S*H"
    And I fill in dvd "Release date" with "01-28-1976"
    And I fill in dvd "Summary" with "M*A*S*H rocks"
    And I select "Alan Alda" for the dvd actor
    When I press dvd button "Create Dvd"
    Then I should see dvd message "Dvd was successfully created."
    And I should see the dvd actor is "Alan Alda"
    When I follow dvd link "Edit"
    And I select "Mike Farrel" for the dvd actor
    When I press dvd button "Update Dvd"
    Then I should see dvd message "Dvd was successfully updated."
    And I should see the dvd actor is "Mike Farrel"





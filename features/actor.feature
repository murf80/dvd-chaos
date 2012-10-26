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
    Given I am on the new "actors" page
    And I fill in "Name" with "Alan Alda"
    And I fill in date with month "January", day "28", and year "1936"
    And I choose "actor_gender_male"
    When I press button "Create Actor"
    Then I should see message "Actor was successfully created."
    And I should see date "01-28-1936"
    When I go to the "actors" index page
    Then I should see date "01-28-1936"

  Scenario: Update date of birth on an actor
    Given I am on the new "actors" page
    And I fill in "Name" with "Alan Alda"
    And I fill in date with month "January", day "28", and year "1936"
    And I choose "actor_gender_male"
    When I press button "Create Actor"
    Then I should see message "Actor was successfully created."
    And I should see date "01-28-1936"
    When I follow link "Edit"
    And I fill in date with month "March", day "28", and year "1936"
    When I press button "Update Actor"
    Then I should see message "Actor was successfully updated."
    And I should see date "03-28-1936"

  Scenario: Ensure users can delete actors from the view page
    Given the following actor exists:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
    And I am on the view page for actor "Alan Alda"
    When I follow link "Destroy"
    Then The actor "Alan Alda" should be destroyed

  Scenario: Ensure users can delete directors from the index page
    Given the following actor exists:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
    And I go to the "actors" index page
    When I follow link "Destroy"
    Then The actor "Alan Alda" should be destroyed

  Scenario: Create actor through the ui with dvds
    Given the following dvd exists:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
    Given I am on the new "actors" page
    And I fill in "Name" with "Alan Alda"
    And I fill in date with month "January", day "28", and year "1936"
    And I choose "actor_gender_male"
    And I select "M*A*S*H" for the dvd name
    When I press button "Create Actor"
    Then I should see message "Actor was successfully created."
    And I should see date "01-28-1936"
    When I am on the view page for actor "Alan Alda"
    Then I should see date "01-28-1936"
    And I should see dvd name is "M*A*S*H"

  Scenario: Update actor dvds through the ui
    Given the following dvds exist:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
      | RAD | RAD (1986)   |
    Given I am on the new "actors" page
    And I fill in "Name" with "Alan Alda"
    And I fill in date with month "January", day "28", and year "1936"
    And I choose "actor_gender_male"
    And I select "M*A*S*H" for the dvd name
    When I press button "Create Actor"
    Then I should see message "Actor was successfully created."
    When I follow link "Edit"
    And I select "RAD" for the dvd name
    When I press button "Update Actor"
    Then I should see message "Actor was successfully updated."
    When I am on the view page for actor "Alan Alda"
    And I should see dvd name is "RAD"

  Scenario: Search directors by partial name
    Given the following director exists:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 02-20-1925 |
    And I go to the "directors" index page
    And I select "Name" for the search type
    And I fill in "search_value" with "Alda"
    When I press button "Search"
    Then I should see message "Alan Alda"

  Scenario: Search directors by partial dvd name
    Given the following director exists:
      | Name      | Gender | dob        |
      | Alan Alda | male   | 01-28-1963 |
    And I am on the new "dvds" page
    Given I fill in "Name" with "M*A*S*H"
    And I fill in "Summary" with "M*A*S*H rocks"
    And I select "Alan Alda" for the dvd director
    When I press button "Create Dvd"
    Then I should see message "Dvd was successfully created."
    When I go to the "directors" index page
    And I select "DVD Name" for the search type
    And I fill in "search_value" with "M*A*S"
    When I press button "Search"
    Then I should see message "Alan Alda"

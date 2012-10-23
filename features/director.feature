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

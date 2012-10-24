Feature: Dvd tests
  Dvd tests.

  Scenario: Create new dvd
    Given the following dvd exists:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
    When I go to the dvds page
    Then I should see dvd "M*A*S*H"
    And I should see one actor for dvd "M*A*S*H"
    And I should see one director for dvd "M*A*S*H"

  Scenario: Create dvd with missing info
    When I add an dvd with no summary
    Then The dvd should be invalid due to missing summary

  Scenario: Create duplicate dvd
    Given the following dvd exists:
      | Name      | Summary |
      | M*A*S*H | M*A*S*H (1973)   |
    When I add a duplicate dvd  with name "M*A*S*H" and summary "M*A*S*H (1973)"
    Then The dvd should be invalid

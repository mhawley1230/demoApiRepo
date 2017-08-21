Feature: Games resource

  Scenario: Get an error if I don't submit parameters
    Given I navigate to /games
    When I don't supply a parameter
    Then I should get a 400 status
    Then I should get an error message saying "Please provide week parameter in query"
    Then I should get an example saying "/games?week=4 OR /games?week=4,5,6 OR /games?week=all"

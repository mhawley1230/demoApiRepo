Feature: Games resource

  Scenario: Get an error if I don't submit parameters
    Given I navigate to games and I don't supply a parameter
    When I run the RAPI testcase 'no parameters'
    Then I should get a 400 status

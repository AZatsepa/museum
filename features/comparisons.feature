Feature: Comparisons
  As user
  I want to see comparisons

  Scenario: I See comparisons
    Given I go to comparisons
    Then I see '1782 - 1943'
    And I see '1943 - 2017'
    And I see '1782 - 2017'

  Scenario: I see maps with comparisons
    Given I go to comparisons
    Then I go to '1782 - 1943'
    And I see '1782 р'
    Then I go to '1943 - 2017'
    And I see '1943 р'
    Then I go to '1782 - 2017'
    And I see '2017 р'
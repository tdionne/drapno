Feature: Dream creation
  In order to populate the site
  A dreamer
  Should be able to create dreams
  
  Scenario: Successful creation
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Add a dream"
    And I fill in "Title" with "My Real Dream"
    And I fill in "Story" with "All this stuff happens"
    And I fill in "Tags" with "dream, weird, stuff"
    And I press "Add Dream"
    
    Then I should see "Dream was successfully created"
    
    When I go to the dreamer page for "email@person.com"
    Then I should see "My Real Dream"
  
  Scenario: Failed creation
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Add a dream"
    And I fill in "Story" with "All this stuff happens"
    And I press "Add Dream"
  
    Then I should see error messages
  
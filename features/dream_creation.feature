Feature: Dream creation
  In order to populate the site
  A dreamer
  Should be able to create dreams
  
  Scenario: Successful creation
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Submit my dream"
    And I fill in "Give your dream a title" with "My Real Dream"
    And I fill in "Describe your dream" with "All this stuff happens"
    And I fill in "dream[tag_list]" with "dream, weird, stuff"
    And I press "Submit my dream"
    
    Then I should see "Dream was successfully created"
    
    When I go to the dreamer page for "email@person.com"
    Then I should see "My Real Dream"

  Scenario: Previews
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Submit my dream"
    And I fill in "Give your dream a title" with "My Real Dream"
    And I fill in "Describe your dream" with "All this stuff happens"
    And I fill in "dream[tag_list]" with "dream, weird, stuff"
    And I press "Preview my dream"

    Then I should see "This is a preview of your dream"
    And I should see "Edit Dream"

    When I press "Submit my dream"
    Then I should see "Dream was successfully created"

    When I go to the dreamer page for "email@person.com"
    Then I should see "My Real Dream"

  Scenario: Failed creation
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Submit my dream"
    And I fill in "Describe your dream" with "All this stuff happens"
    And I press "Submit my dream"
  
    Then I should see error messages
  
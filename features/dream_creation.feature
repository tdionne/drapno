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

  Scenario: Successful creation with appearance and relationship
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Submit my dream"
    And I fill in "Give your dream a title" with "My Real Dream"
    And I fill in "Describe your dream" with "All this stuff happens"
    And I fill in "dream[tag_list]" with "dream, weird, stuff"
    And I fill in "Their Name" with "My Friend"
    And I fill in "Your Relationship" with "Close personal friends"
    And I fill in "Their Role" with "Fancy bartender"
    And I fill in "Their Email" with "example@person.com"
    And I check "Let Them Know"
    And I press "Submit my dream"

    Then I should see "Dream was successfully created"
    And an email should be sent to "example@person.com"
    And I should see "My Real Dream"
    And I should see "Close personal friends"

  Scenario: Successful creation with appearance but not notification
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Submit my dream"
    And I fill in "Give your dream a title" with "My Real Dream"
    And I fill in "Describe your dream" with "All this stuff happens"
    And I fill in "dream[tag_list]" with "dream, weird, stuff"
    And I fill in "Their Name" with "My Friend"
    And I fill in "Your Relationship" with "Close personal friends"
    And I fill in "Their Role" with "Fancy bartender"
    And I fill in "Their Email" with "example@person.com"
    And I uncheck "Let Them Know"
    And I press "Submit my dream"

    Then I should see "Dream was successfully created"
    And an email should not be sent
    And I should see "My Real Dream"
    And I should see "Close personal friends"


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
  
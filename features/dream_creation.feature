Feature: Dream creation
  In order to populate the site
  A dreamer
  Should be able to create dreams
  
  Scenario: Successful creation
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Submit my dream"
    And I fill in the following:
      | Give your dream a title | My Real Dream |
      | Describe your dream | All this stuff happens |
      | dream[tag_list] | dream, weird, stuff |
    And I press "Submit my dream"
    
    Then I should see "Dream was successfully created"
    
    When I go to the dreamer page for "email@person.com"
    Then I should see "My Real Dream"

  Scenario: Successful creation with appearance and relationship
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Submit my dream"
    And I fill in the following:
      | Give your dream a title | My Real Dream |
      | Describe your dream | All this stuff happens |
      | dream[tag_list] | dream, weird, stuff |
      | Their Name | My Friend |
      | Your Relationship | Close personal friends |
      | Their Role | Fancy bartender |
      | Their Email | example@person.com |
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
    And I fill in the following:
      | Give your dream a title | My Real Dream |
      | Describe your dream | All this stuff happens |
      | dream[tag_list] | dream, weird, stuff |
      | Their Name | My Friend |
      | Your Relationship | Close personal friends |
      | Their Role | Fancy bartender |
      | Their Email | example@person.com |
    And I uncheck "Let Them Know"
    And I press "Submit my dream"

    Then I should see "Dream was successfully created"
    And an email should not be sent
    And I should see "My Real Dream"
    And I should see "Close personal friends"
    And I should not see "Your Comment"
    And I should see "This dream has yet to be rated"
    And I should not see "Rate this dream"

  Scenario: Previews
    Given I am signed up and confirmed as "email@person.com/password"

    When I sign in as "email@person.com/password"
    And I follow "Submit my dream"
    And I fill in the following:
      | Give your dream a title | My Real Dream |
      | Describe your dream | All this stuff happens |
      | dream[tag_list] | dream, weird, stuff |
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
  
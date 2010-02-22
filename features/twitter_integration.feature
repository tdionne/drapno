Feature: Twitter Integration
  In order to spread the word
  A dreamer
  Should be able to share their dreams on twitter
  
  Background:
    Given I have signed in with "email@person.com/password"
  
  @external
  Scenario: Authorising a twitter account with full oauth practice
    When I go to "the services page"  
    And I follow "twitter"
    And I follow the redirect
    And I press "Allow"
    
    Then I should be on the homepage
    And I should see "Twitter was successfully connected to your account"
    And I should have twitter credentials in the database    
    
  Scenario: Authorising a twitter account
    When I go to "the services page"  
    And I follow the stubbed oauth link to twitter

    Then I should be on the homepage
    And I should see "Twitter was successfully connected to your account"
    And I should have twitter credentials in the database
  
  Scenario: Tweeting a dream
    Given I have authorised twitter for my account
    When I go to the new dream page
    And I fill in the following:
      | Give your dream a title | My Real Dream |
      | Describe your dream | All this stuff happens |
      | dream[tag_list] | dream, weird, stuff |
  
    And I check "Post this dream to twitter?"
    And I press "Submit my dream"
    
    Then a background job should be set up to post to twitter

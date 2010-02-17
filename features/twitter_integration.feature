Feature: Twitter Integration
  In order to spread the word
  A dreamer
  Should be able to share their dreams on twitter
  
  Background:
    Given I have signed in with "email@person.com/password"

  Scenario: Authorising with twitter oauth
    When I go to "the oauth page"  
    And I follow the oauth link to twitter

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

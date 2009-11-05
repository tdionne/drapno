Feature: Commenting
  In order to make the site come to life
  Registered dreamers
  Should be able to send some feedback
  
  Background:
    Given the following users:
      | name | email | password | password_confirmation |
      | Other user | other@person.com | password | password |
    And I am signed up and confirmed as "email@person.com/password"
    And the following dreams exist:
      | title           | story              |
      | My First Dream  | Something happened |
      | My Other Dream  | Another happening  |
    And all dreams were created by "other@person.com"
  
  Scenario: Not logged in
    When I go to the dream page for "My First Dream"
    Then I should see "You must be signed in to comment"

  Scenario: Successful commenting
    When I sign in as "email@person.com/password"
    And I go to the dream page for "My First Dream"
    
    And I fill in "Comment" with "Something important"
    And I press "Add Comment"
    
    Then I should see "Thank you for your comment"
    And I should see "Something important"

  Scenario: Logged in but entered bad data
    When I sign in as "email@person.com/password"
    And I go to the dream page for "My First Dream"
  
    And I fill in "Comment" with ""
    And I press "Add Comment"
  
    Then I should see "Sorry: we weren't able to save your comment"

Feature: Reporting a comment
  As a responsible user
  I want to be able to flag inappropriate comments
  So I can make sure my wisdom isn't tainted by malicious commenters
  
  Background:
    Given I am signed up and confirmed as "email@person.com/password"
    And the following dreams exist:
      | title           | story              |
      | My First Dream  | Something happened |
      | My Other Dream  | Another happening  |

    And the following comments exist on "My First Dream":
        | body                              | 
        | something distinctly not profound | 
    
    Scenario: Viewing dream page but not logged in
      When I go to the dream page for "My First Dream"
      Then I should be on the dream page for "My First Dream"
      And I should see "Sign up or sign in to report inappropriate comments"
    
    Scenario: Viewing the dream page when logged in
      When I sign in as "email@person.com/password"
      And I go to the dream page for "My First Dream"
      Then I should see "Report this?"
    
    Scenario: Logged in and reporting a comment
      Given I sign in as "email@person.com/password"
      And I go to the dream page for "My First Dream"
    
      When I follow "Report this?"
      
      Then I should see "something distinctly not profound"
      And I should see a field to explain my reason
    
    Scenario: Completing the reporting process
      Given I sign in as "email@person.com/password"
      And I go to the dream page for "My First Dream"
      And I follow "Report this?"
      
      When I fill in "comment_report[reason]" with "It's really quite bad"
      And I press "Report Comment"
      
      Then I should be on the dream page for "My First Dream"
      And I should see "Thank you. We have noted your concern."
      And I should see "My First Dream"

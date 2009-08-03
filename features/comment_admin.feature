Feature: Comment Administration
  As an administrator
  I want to be able to manage comments
  To keep the site safe from bad/illegal comments
  And to keep our users happy
  
  Background:
    Given I am signed up and confirmed as "test@example.com/testuser"
    And "test@example.com" is an admin user
    And the following dreams exist:
      | title           | story              |
      | My First Dream  | Something happened |
      | My Other Dream  | Another happening  |
    And the following comments exist on "My First Dream":
        | body                              | status  |
        | something distinctly not profound | reported |
    And the following reports exist on the first comment
        | reason          | 
        | I don't like it |

  Scenario: Visiting the comment admin homepage
    When I sign in as "test@example.com/testuser"    
    And I go to the admin comments page
    And I select "reported" from "Filter comments by status"
    And I press "Go"
    
    Then I should see "Listing comments with status: Reported"
    And I should see "My First Dream"
  
  Scenario: Viewing a reported comment
    When I sign in as "test@example.com/testuser"    
    And I go to the first reported comment page

    Then I should see "1 time"
    And I should see "I don't like it"
  
  Scenario: Marking a comment as spam
    When I sign in as "test@example.com/testuser"    
    And I go to the first reported comment page
    And I select "spam" from "Status"
    And I press "Update"
    
    Then I should be on the admin comments page
    And I should see "Comment was successfully updated"
  
  Scenario: Marking a comment as spam and visiting the dream page
    When I sign in as "test@example.com/testuser"    
    And I go to the first reported comment page
    And I select "spam" from "Status"
    And I press "Update"
    And I go to the dream page for "My First Dream"
    
    Then I should not see "something distinctly not profound"
  
  Scenario: Marking a comment as hidden and visiting the entry page
    When I sign in as "test@example.com/testuser"    
    And I go to the first reported comment page
    And I select "hidden" from "Status"
    And I press "Update"
    And I go to the dream page for "My First Dream"
  
    Then I should not see "something distinctly not profound"
    And I should see "A comment that was here has been removed for breaching our policies"
Feature: Profile editing
  In order to give their dreams some context
  A dreamer
  Should be able to edit their profile
  
  Background:
    Given I am signed up and confirmed as "email@person.com/password"
    And I am signed in as "email@person.com/password"
    
  Scenario: Successful edit
    Given I am on the homepage

    When I follow "Edit profile"    
    And I fill in "Location" with "London"
    And I select "Male" from "Gender"
    And I select "26-35" from "Age band"
    And I press "Save Changes"
    
    Then I should see "Profile successfully updated"
    And I should see "Male"
    And I should see "London"
    And I should see "26-35"
    
  Scenario: Unsuccessful edit
    Given I am on the homepage

    When I follow "Edit profile"    
    And I fill in "Email" with ""
    And I press "Save Changes"
    
    Then I should see error messages
Feature: Invitation Only
  In order to limit signups
  Site administrators
  May restrict access to those with invitations

  Background:
    Given the site is in invitation only mode
    
  Scenario: Visiting without an invitation
    When I go to the homepage
  
    Then I should be on the sign in page
    And I should see "If you don't have an account and would like an invitation, please get in touch"
    
  Scenario: Visiting with an invitation
    Given an invitation has been issued to "me@mysite.com"
  
    When I follow the invitation link for "me@mysite.com"
  
    Then I should be on the sign up page
    And I should see "We've pre-filled some values from the invitation you received"
    And the "Email" field should contain "me@mysite.com"
    
    When I fill in "Name" with "My Name"
    And I fill in "Password" with "MyPassword"
    And I fill in "Confirm password" with "MyPassword"
    And I press "Sign up"
    
    Then I should see "instructions for confirming"
  
  Scenario: Confirming account
    Given I signed up with an invitation as "email@person.com/password"
    When I follow the confirmation link sent to "email@person.com"
    Then I should see "Confirmed email and signed in"
    And I should see "Edit Profile"
    
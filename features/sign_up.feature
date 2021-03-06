Feature: Sign up
  In order to get access to protected sections of the site
  A dreamer
  Should be able to sign up

  Background:
    Given the site is not in invitation only mode
  
    Scenario: User signs up with invalid data
      When I go to the sign up page
      And I fill in "Email" with "invalidemail"
      And I fill in "Password" with "password"
      And I fill in "Confirm password" with ""
      And I press "Sign Up"
      Then I should see error messages

    Scenario: User signs up with valid data
      When I go to the sign up page
      And I fill in "Name" with "James"
      And I fill in "Email" with "email@person.com"
      And I fill in "Password" with "password"
      And I fill in "Confirm password" with "password"
      And I press "Sign Up"
      Then I should see "instructions for confirming"
      And I should see "If you don't see it within a few minutes don't forget to check your junk/spam mailbox"
      And a confirmation message should be sent to "email@person.com"

    Scenario: User confirms his account
      Given I signed up with "email@person.com/password"
      When I follow the confirmation link sent to "email@person.com"
      Then I should see "Confirmed email and signed in"
      And I should be signed in


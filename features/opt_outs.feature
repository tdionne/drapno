Feature: Opt Out
  In order to manage their attention
  An apparition
  Should be able to request no more emails be sent to them

  Background:
    Given the site is not in invitation only mode
      
  Scenario: Opting out
  
    Given I have appeared in a dream with the email address "test@example.com"
    When I follow the opt out link
    Then I should see "You are requesting to opt out of future notifications from Drapno."
  
    When I press "Submit"
    Then I should be on the homepage
    And I should see "You will not receive more appearance notifications"
  
  Scenario: Opted out user opting in
    Given I am signed up and confirmed as "email@person.com/password"
    And I am signed in as "email@person.com/password"
    And I have appeared in a dream with the email address "email@person.com"
    And I followed the opt out link
    And I pressed "Submit"
    
    When I go to the dreamer page for "email@person.com"
    And I press "Opt back in"
    Then I should be on the dreamer page for "email@person.com"
    And I should see "From now on you will receive dream appearance notifications"
    
@javascript
Feature: Invite members
  In order to increase the number of users
  I should be able to invite my family
  So I can have all the real members in my group

  Scenario: I'm invited on an existing family
    Given I'm a logged in user
    And I'm part of a family
    And I go to the new invitation page
    And I fill in "Email" with "someone@invited.now"
    And I press "Create Invitation"
    Then "someone@invited.now" should receive an email
    Given I'm logged out
    When I open the email
    Then I should see "Hello someone@invited.now!" in the email body
    When I sign up using "someone@invited.now" as email
    Then I should have an invitation pending
    When I accept this invitation
    Then my family should have 2 members

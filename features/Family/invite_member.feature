@wip
Feature: Invite members
  In order to increase the number of users
  I should be able to invite my family
  So I can have all the real members in my group

  Scenario: I'm invited on an existing family
    Given I'm a logged in user
    And I'm part of a family
    And I'm on the index page of my family
    And the name of my family is "LesChaudsLapins"
    When I follow "Invite your family"
    And I fill in "user_email" with "toto@le.loco"
    And I press "Send an invitation"
    Then "toto@le.loco" should receive an email
    Given I'm logged out
    When I open the email
    Then I should see "Hello toto@le.loco!" in the email body
    When I follow "Accept invitation" in the email
    Then I should see "Set your password"
    And I fill in the following fields:
      | field | value |
      | user_password | toto42        |
      | user_password_confirmation | toto42 |
    When I press "Set my password"
    Then I should see "LesChaudsLapins"
    And the family "LesChaudsLapins" should have 2 members

@wip
Feature: Invite members
  In order to increase the number of users
  I should be able to invite my family
  So I can have all the real members in my group

  Background:
    Given I'm a logged in user
    And I'm part of a family
    And I'm on the index page of my family
    And the name of my family is "LesChaudsLapins"

  Scenario: I'm invited on an existing family
    When I follow "Invite your family"
    And I fill in "user_email" with "toto@le.loco"
    And I press "Send an invitation"
    Then "toto@le.loco" should receive an email
    When the invited user clicks on the link to join familyMe
    And he fills in the form with correct informations
    When I click on "Create"
    Then the page should contain "LesChaudsLapins"
    And the family "LesChaudsLapins" should have 2 members

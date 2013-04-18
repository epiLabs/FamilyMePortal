Feature: Invite members
  In order to increase the number of users
  I should be able to invite my family
  So I can have all the real members in my group

  @wip
  Scenario: I'm invited on an existing family
    Given I'm a logged in user
    And I'm part of a family
    And I'm on the index page of my family
    When I follow "Invite your family"
    And I fill in "user_email" with "toto@le.loco"
    And I press "Send an invitation"
    Then "toto@le.loco" should receive an email
    Given I'm logged out
    When I open the email
    Then I should see "Hello toto@le.loco!" in the email body
    When I sign up using "toto@le.loco" as email
    Then I should have an invitation pending
    When I accept this invitation
    Then my family should have 2 members

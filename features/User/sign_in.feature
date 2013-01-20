Feature: Sign in a created user
  In order to let people access to my application
  As a regegistered user, I can sign in
  So I can add more value to my content

  Scenario: A user can sign in
    Given a registered user "toto42@toto.fr"
    And I'm on the login page
    And I fill in the log in form with correct informations
    And I press "Sign in"
    Then I should be signed in

  Scenario: A user can sign in through the API
    Given I accept JSON
    Given a registered user "toto42@toto.fr"
    When I post the following to authenticate through the API:
      | field          | value |
      | user[email]    | toto42@toto.fr |
      | user[password] | toto42 |
    Then the last reponse shouldn't contain any error

  Scenario: I should receive a a token when I sign in through the API
    Given a registered user "toto42@toto.fr"
    And I sign in through the api
    Then I should have received an authentication token

  Scenario: A user cannot sign in with bad informations
    Given a registered user "toto42@toto.fr"
    And I'm on the login page
    And I fill in the log in form with wrong informations
    And I press "Sign in"
    Then I see an invalid login message
    And I should be signed out


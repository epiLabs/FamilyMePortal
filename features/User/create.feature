Feature: Create user features
  In order to let people access to my application
  As a user oriented application
  They should be able to have an account

  Scenario: A visitor can sign up
    Given I'm a future user visiting the homepage
    When I click on "Sign up"
    And I fill in the following fields:
      | field | value |
      | user_email | toto42@blabla.fr |
      | user_password | toto42        |
      | user_password_confirmation | toto42 |
    And I press "Sign up"
    Then I should be signed in

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

  Scenario: A user cannot sign in with bad informations
    Given a registered user "toto42@toto.fr"
    And I'm on the login page
    And I fill in the log in form with wrong informations
    And I press "Sign in"
    Then I see an invalid login message
    And I should be signed out

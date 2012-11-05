Feature: User features
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
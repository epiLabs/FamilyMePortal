Feature: Access backend features
  In order to have a relevant application
  As a user
  I should be able to access to backend features

  Scenario: A logged-in user sees the backend instead of the homepage
    Given I'm a logged in user
    When I visit the homepage
    Then I should see a form to create my family

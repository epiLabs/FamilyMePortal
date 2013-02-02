@javascript
Feature: Post and read messages
  In order to have more interaction in my family
  I should be able to post messages
  So I can give the user more interactivity

  Scenario: I create and delete a message
    Given I'm a logged in user
    And I'm part of a family
    When I'm on the index page of my family
    And I click on the "Wall" tab
    When I create a new post "THIS IS SPARTAAAAAAA!"
    Then I should a post containing "THIS IS SPARTAAAAAAA!"
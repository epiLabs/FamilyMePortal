@wip
Feature: Post and read messages
  In order to have more interaction in my family
  I should be able to post messages
  So I can give the user more interactivity

  Background:
    Given I'm a logged in user
    And I'm part of a family
    When I'm on the index page of my family
    When I create a new post "THIS IS SPARTAAAAAAA!"
    Then I should see "THIS IS SPARTAAAAAAA!"
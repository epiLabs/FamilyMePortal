@javascript
Feature: Post and read messages
  In order to have more interaction in my family
  I should be able to post messages
  So I can give the user more interactivity

  Background:
    Given I'm a logged in user
    And I'm part of a family
    Given another member of my family has created a post
    When I'm on the dashboard of my family

  Scenario: I create and delete a message
    When I create a new post "THIS IS SPARTAAAAAAA!"
    Then I should a post containing "THIS IS SPARTAAAAAAA!"
    And there should be 2 posts
    When I click on the cross to delete my post
    And there should be 1 post
    And I shouldn't see a post containing "THIS IS SPARTAAAAAAA!"

  Scenario: I can't delete other's posts
    Then I shouldn't see any cross on the post

Feature: Interact with family
  In order to have my users into groups
  I should be able to interact with my family
  So I can give the user more interactivity

  Background:
    Given I'm a logged in user
    And I'm part of a family
    When I'm on the index page of my family

  Scenario: I list the members of my family
    Then I should see myself on the family's user listing
    
  # Scenario: Sending a message to another member
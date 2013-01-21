Feature: I checkout my position and retrieve other member's
  In order to build better mobile applications
  As a signed in user, I can retrieve various informations about my family
  So I can add more value to my content

  Background:
    Given I use the api "v1"
    Given a family with the following members:
      | email | password | first_name | last_name | nickname |
      | elisa@orange.fr | toto42 | elisa | goin | pink_lady |
    Given I'm a registered user "jose@free.fr" who's part of this family
    And I sign in through the api

  Scenario: I post valid coordinates
    When I post the following to checkout my position:
      | field               | value     |
      | position[latitude]  | 42.989283 | 
      | position[longitude] | -1.35309 | 
    When I list my positions on the api
    Then I should see "31640 Burguete, Navarra, Spain"
    When I'm on the page of family through the api
    Then I should see "31640 Burguete, Navarra, Spain"

  Scenario Outline: I post invalid coordinates
    When I post the following to checkout my position:
      | field               | value       |
      | position[latitude]  | <latitude>  | 
      | position[longitude] | <longitude> |
    Then the last reponse should contain an error

  Examples:
    | latitude  | longitude |
    | -99.34442 | 0.0034324 |
    | 54.424232 | 192.34355 |
    | 90.000001 | 1.2349829 |

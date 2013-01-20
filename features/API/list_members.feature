Feature: I can list the members of my family
  In order to build better mobile applications
  As a signed in user, I can retrieve various informations about my family
  So I can add more value to my content

  Background:
    Given I use the api "v1"
    Given a family with the following members:
      | email | password | first_name | last_name | nickname |
      | dede@free.fr | toto42 | patrick | goin | mastah42 |
      | elisa@orange.fr | toto42 | elisa | goin | pink_lady |
      | marco@free.fr | toto42 | marco | fion | razzor64 |

  Scenario: I list the members of my family
    Given I'm a registered user "jose@free.fr" who's part of this family
    And I sign in through the api
    When I'm on the page of family through the api
    Then I should see "pink_lady"
    And I should see "razzor64"
    And I should see "mastah42"

  Scenario: I receive an error if I'm not part of a family
    Given a registered user "not_in_a_family@free.fr"
    And I sign in through the api
    When I'm on the page of family through the api
    Then the page response code should be 404

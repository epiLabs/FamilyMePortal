Feature: Create family
  In order to have my users into groups
  I should be able to create a family
  So I can add more value to my content

Background:
  Given I'm a logged in user
  When I visit my family page

Scenario: I can create a family when I'm logged in
  Then I should see a notice
  When I fill in "family_name" with "Hellomoto"
  And I press "Create Family"
  Then It should create a family "Hellomoto"
  And I should be redirected to my family index

Scenario Outline: Creating family with wrong informations
  When I fill in "family_name" with <name>
  And I press "Create Family"
  Then I should see an error
  And I should be on the new family page

Examples:
  |  name           |
  |  ""             |
  |  "2323"         |
  |  "a"            |
  |  "bad name ^"   |
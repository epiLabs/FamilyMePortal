Feature: Create family
  In order to have my users into groups
  I should be able to create a family
  So I can add more value to my content

Background:
  Given I'm a logged in user
  When I visit my family page

Scenario: I can create a family when I'm logged in
  Then I should see "You should create a family or wait to be invited into one!"
  And I follow "Create your family now"
  Then It should create a family
  And I should be on the new family page

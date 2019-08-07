Feature: Manage lists
  In order to keep different tasks separated
  As a user
  I want to be able to manage multiple lists

  Scenario:
  Initiate new list

    Given I am on the front page
    When I initiate a new list
    Then I navigate to the new list page

  Scenario Outline:
  Create new list

    Given I am on the new list page
    When I enter the title "<Title>"
    And I enter the description "<Description>"
    And I create a new list
    Then a new list is <maybe> created
    And the page contains "<Title>"
    And the page contains "<Description>"
  Examples:
    | Title         | Description                 | maybe       |
    | Agnetas lista | Saker att köpa på vägen hem | successfully|
    |               | bilens reservdelar          | not         |
    | Nattbio       |                             | successfully|
    |               |                             | not         |
    | Innan jul     | Baka pepparkakor            | successfully|

   Scenario Outline:
   Edit existing list

     Given I am on the list page
     When I edit the existing list "<Title>"
     And I change <type> to "<New text>"
     And I update the list
     Then the list is <maybe> updated
     And the page contains "<New text>"
   Examples:
     | Title               | type        | New text            | maybe        |
     | Agnetas lista       | title       | Agnetas nya lista   | successfully |
     | Agnetas nya lista   | title       |                     | not          |
     | Nattbio             | description | Att göra innan bion | successfully |
     | Att göra innan bion | description |                     | successfully |


  Scenario Outline:
  Delete existing list

    Given I am on the list page
    When I delete the list "Innan jul" and <accept> the deletion
    Then I am <maybe> navigated to the list page
    And the list "Innan jul" is <maybe> deleted

  Examples:
    | accept | maybe        |
    | reject | not          |
    | accept | successfully |

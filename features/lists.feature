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
  Edit new list

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
    | 😸            | 😊                          | not        |

  Scenario:
  Edit existing list

    Given I am on the list page
    When I edit the existing title "<Title>"
    And I edit the existing description "<Description>"
    And I update the list
    Then the list is <maybe> updated
    And the page contains new title
    And the page contains new description


  Scenario Outline:
  Deleting existing list

    Given I am on the list page
    When I delete list page
    And I affirm the verification
    Then the list is <maybe> deleted
    And I am navigated to the front page

  Examples:
    | Affirmation   | maybe        |
    | OK            | successfully |
    | Avbryt        | not          |

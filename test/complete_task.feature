Feature: we can move tasks.

Scenario: move one task
    Given, we have imported the webdriver library
    When we ask to move a task from today to completed
    Then the task is successfully moved.
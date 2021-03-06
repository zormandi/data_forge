Feature: Deleting files

  The `trash` command can be used to delete files belonging to file definitions that are no longer useful.


  Scenario: Successful execution
    Given an empty file named "one.csv"
    And an empty file named "two.csv"
    And an empty file named "three.csv"
    And a file named "command_script.rb" with:
    """
    file :one
    file :two
    file :three

    trash :one, :three
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And the following files should exist:
      | two.csv |
    And the following files should not exist:
      | one.csv   |
      | three.csv |

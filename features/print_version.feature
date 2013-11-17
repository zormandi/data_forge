Feature: Print version information

  Invoking the `forge` command with the --version option prints the version information.

  Scenario: Success
    When DataForge is run with the "--version" argument
    Then the result should be success
    And the output should contain:
    """
    DataForge, version 0.0.1
    """

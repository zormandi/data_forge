Feature: Print version information

  Invoking the `forge` command with the --version option prints the version information.

  Scenario: Success
    When DataForge is run with the "--version" argument
    Then the process should exit successfully
    And the output should contain:
    """
    DataForge, version 0.0.1
    """

Feature: Print version information

  Invoking the `forge` command with the --version switch prints the version information.


  Scenario: Success
    When I run `forge --version`
    Then the exit status should be 0
    And the stdout should contain "DataForge, version 0.0.1"

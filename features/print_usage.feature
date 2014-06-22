Feature: Print usage information

  If the `forge` command is invoked with an unsupported number of arguments or the --help switch
  then it prints information on how to use the script.


  Scenario: Invoked with no arguments
    When I run `forge`
    Then the exit status should be 1
    And the stderr should contain:
    """
    ERROR: no command file specified

    Usage: forge [--help|--version|command script file]

    forge --help           Prints this page.
    forge --version        Prints version information.
    forge command_file.rb  Executes instructions in command_file.rb.
    """


  Scenario: Invoked with more than one argument
    When I run `forge one two`
    Then the exit status should be 1
    And the stderr should contain:
    """
    ERROR: executing more than one command file is currently not supported

    Usage: forge [--help|--version|command script file]

    forge --help           Prints this page.
    forge --version        Prints version information.
    forge command_file.rb  Executes instructions in command_file.rb.
    """


  Scenario: Invoked with the --help switch
    When I run `forge --help`
    Then the exit status should be 0
    And the stdout should contain:
    """
    Usage: forge [--help|--version|command script file]

    forge --help           Prints this page.
    forge --version        Prints version information.
    forge command_file.rb  Executes instructions in command_file.rb.
    """

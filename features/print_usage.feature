Feature: Print usage information

  If the `forge` command is invoked with an unsupported number of arguments or the --help switch
  then it prints information on how to use the script.


  Scenario: Invoked with no arguments
    When DataForge is run with no argument
    Then the process should exit with an error
    And the error message should contain:
    """
    ERROR: no command file specified

    Usage: forge [--help|--version|command script file]

    forge --help           Prints this page.
    forge --version        Prints version information.
    forge command_file.rb  Executes instructions in command_file.rb.
    """


  Scenario: Invoked with more than one argument
    When DataForge is run with the "one two" arguments
    Then the process should exit with an error
    And the error message should contain:
    """
    ERROR: executing more than one command file is currently not supported

    Usage: forge [--help|--version|command script file]

    forge --help           Prints this page.
    forge --version        Prints version information.
    forge command_file.rb  Executes instructions in command_file.rb.
    """


  Scenario: Invoked with the --help switch
    When DataForge is run with the "--help" argument
    Then the process should exit successfully
    And the output should contain:
    """
    Usage: forge [--help|--version|command script file]

    forge --help           Prints this page.
    forge --version        Prints version information.
    forge command_file.rb  Executes instructions in command_file.rb.
    """

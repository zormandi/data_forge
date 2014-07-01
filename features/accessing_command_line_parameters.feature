Feature: Accessing command line parameters

  The following command line parameters are available in the command script during execution:
  - COMMAND_SCRIPT: The name of the command script currently executing.
  - PARAMS: The user-defined parameters passed to the script as a hash.


  Scenario: Accessing the command script
    Given a file named "config.rb" with:
    """
    File.write 'script_name.txt', COMMAND_SCRIPT
    """
    And a file named "command_script.rb" with:
    """
    require_relative 'config'
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "script_name.txt" should exist
    And the file "script_name.txt" should contain "command_script.rb"


  Scenario: Passing user-defined parameters to a file definition and a transform block
    Given a file named "command_script.rb" with:
    """
    file :items do
      file_name PARAMS[:data_file]
      field :id
    end

    transform :items do |record|
      record[:id] = PARAMS[:id]
      output record
    end
    """
    And a file named "ids.csv" with:
    """
    id
    1
    2
    3
    """
    When I run `forge -Udata_file=ids.csv -Uid=5 command_script.rb`
    Then the exit status should be 0
    And the file "ids.csv" should contain exactly:
    """
    id
    5
    5
    5

    """

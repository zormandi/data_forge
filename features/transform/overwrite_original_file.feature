Feature: Overwriting the original file with a transformation

  If the argument to a `transform` block is a single file (or rather, its name as a symbol) then both the source
  and the target of that transformation will be the specified file. In this case the data in the file will be
  processed and the file overwritten with the transformed data.


  Scenario:
    Given a file named "command_script.rb" with:
    """
    file :items do
      field :name
    end

    transform :items do |record|
      record[:name] = record[:name][0]
      output record
    end
    """
    And a file named "items.csv" with:
    """
    name
    ab
    cd
    ef
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "items.csv" should exist
    And the file "items.csv" should contain exactly:
    """
    name
    a
    c
    e

    """

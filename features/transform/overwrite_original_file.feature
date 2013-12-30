Feature: Overwriting the original file with a transformation

  If the argument to a `transform` block is a single file (or rather, its name as a symbol) then both the source
  and the target of that transformation will be the specified file. In this case the data in the file will be
  processed and the file overwritten with the transformed data.


  Scenario:
    Given the following command script:
    """
    file :items do
      field :name
    end

    transform :items do |record|
      record[:name] = record[:name][0]
      output record
    end
    """
    And an "items.csv" file containing:
    """
    name
    ab
    cd
    ef
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "items.csv" file containing:
    """
    name
    a
    c
    e
    """

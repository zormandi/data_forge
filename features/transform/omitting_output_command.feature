Feature: A transformation without an 'output' call creates an empty file

  The `output` command in a transformation block writes the specified data into the output file. Omitting this
  command conditionally will skip the current record and omitting it unconditionally will simply create an
  empty file without outputting any data into it.


  Background:
    Given an "items.csv" file containing:
    """
    id
    1
    2
    3
    """


  Scenario: No output in transform block creates empty file
    Given the following command script:
    """
    file :items do
      field :id
    end

    file :items_empty do
      field :id
    end

    transform :items => :items_empty do end
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "items_empty.csv" file containing:
    """
    """


  Scenario: Omitting output conditionally skips current record
    Given the following command script:
    """
    file :items do
      field :id
    end

    file :items_missing do
      field :id
    end

    transform :items => :items_missing do |record|
      output record unless "2" == record[:id]
    end
    """
    When the command script is executed
    Then there should be a "items_missing.csv" file containing:
    """
    id
    1
    3
    """

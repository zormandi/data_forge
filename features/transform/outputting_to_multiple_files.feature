@wip
Feature: Splitting a file into multiple files

  The `transform` block can take multiple output file parameters, in which case the `output` command can be used
  to specify which file to write to.


  Scenario:
    Given the following command script:
    """
    file :items do
      field :name
    end

    file :items_not_a do
      field :name
    end

    file :items_not_b do
      field :name
    end

    transform :items => [:items_not_a, :items_not_b] do |record|
      if record[:name].start_with "a"
        output record, to: :items_not_b
      elsif record[:name].start_with "b"
        output record, to: :items_not_a
      else
        output record, to: [:items_not_a, :items_not_b]
      end
    end
    """
    And an "items.csv" file containing:
    """
    name
    a
    b
    c
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "items_not_a.csv" file containing:
    """
    name
    b
    c
    """
    And there should be an "items_not_b.csv" file containing:
    """
    name
    a
    c
    """

Feature: Splitting a file into multiple files

  The `transform` block can take multiple output file parameters, in which case the `output` command can be used
  to specify which file to write to.


  Scenario:
    Given a file named "command_script.rb" with:
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

    transform :items, into: [:items_not_a, :items_not_b] do |record|
      if record[:name].start_with? "a"
        output record, to: :items_not_b
      elsif record[:name].start_with? "b"
        output record, to: :items_not_a
      else
        output record, to: [:items_not_a, :items_not_b]
      end
    end
    """
    And a file named "items.csv" with:
    """
    name
    a
    b
    c
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And the following files should exist:
      | items_not_a.csv |
      | items_not_b.csv |
    And the file "items_not_a.csv" should contain exactly:
    """
    name
    b
    c

    """
    And the file "items_not_b.csv" should contain exactly:
    """
    name
    a
    c

    """

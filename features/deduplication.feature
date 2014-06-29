Feature: Deduplicating data in a file

  The `deduplicate` keyword can be used to remove duplicate records from a file. Only the first occurence of each
  duplicate record is kept.

  Parameters:
  - The source file to be deduplicated. This parameter is mandatory.
  - into: The target file name. If no target file is specified then the source file is overwritten with the result
  of the deduplication.
  - using: The fields to be used to determine whether or not a record is a duplicate. If not specified then all
  fields of the source file are used.


  Scenario: Single file transformation
    Given a file named "command_script.rb" with:
    """
    file :items do
      field :rownum
      field :item_id
      field :item_name
    end

    file :unique_items do
      field :item_id
      field :item_name
    end

    deduplicate :items, into: :unique_items, using: :item_id
    """
    And a file named "items.csv" with:
    """
    rownum,item_id,item_name
    1,Item1,Item name 1
    2,Item1,Item name 1
    3,Item2,Item name 2
    4,Item2,Item name 2
    5,Item3,Item name 3
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "unique_items.csv" should exist
    And the file "unique_items.csv" should contain exactly:
    """
    item_id,item_name
    Item1,Item name 1
    Item2,Item name 2
    Item3,Item name 3

    """

Feature: Deduplicating data in a file




  Scenario: Singe file transformation
    Given the following command script:
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
    And an "items.csv" file containing:
    """
    rownum,item_id,item_name
    1,Item1,Item name 1
    2,Item1,Item name 1
    3,Item2,Item name 2
    4,Item2,Item name 2
    5,Item3,Item name 3
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be a "unique_items.csv" file containing:
    """
    item_id,item_name
    Item1,Item name 1
    Item2,Item name 2
    Item3,Item name 3
    """

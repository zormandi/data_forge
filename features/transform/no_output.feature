Feature: A transformation without an 'output' call creates an empty file

  If the transformation block of a transform definition doesn't contain an 'output' call then the transformation
  will simply create an empty file without outputting any data into it.


  Scenario: No output in transform
    Given the following command script:
    """
    file :items do
      field :id, String
    end

    file :items_copy do
      field :id, String
    end

    transform :items => :items_copy do |record|
    end
    """
    And an "items.csv" file containing:
    """
    id,name,category
    1,Item 1,Category 1
    2,Item 2,Category 2
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "items_copy.csv" file containing:
    """
    """

Feature: A transformation without an 'output' call creates an empty file

  If the transformation block of a transform definition doesn't contain an 'output' call then the transformation
  will simply create an empty file without outputting any data into it.


  Scenario: No output in transform
    Given the following command script:
    """
    file :items do
      field :id
    end

    file :items_copy do
      field :id
    end

    transform :items => :items_copy do |record|
    end
    """
    And an "items.csv" file containing:
    """
    id
    1
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "items_copy.csv" file containing:
    """
    """

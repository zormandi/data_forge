Feature: Copy file without any transformation

  If two file definitions are identical (or the target file's fields are a subset of the source files fields)
  then a transformation which does nothing but simply output every record makes an exact copy of the source file.


  Scenario: Copy file
    Given the following command script:
    """
    file :items do
      field :id
      field :name
      field :category
    end

    file :items_copy do
      field :id
      field :name
      field :category
    end

    transform :items => :items_copy do |record|
      output record
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
    id,name,category
    1,Item 1,Category 1
    2,Item 2,Category 2
    """

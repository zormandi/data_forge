Feature: File `has_header` option

  The `has_header_row` option of a `file` block specifies whether or not the corresponding CSV file has a header row.
  If a file is specified to have a header row then the first row of the file is skipped during transformation.
  If not, then all rows of the file are processed. When writing into files with a header row, the fields specified
  for that file are written as the header of the CSV file. If an output file is specified to have no header then
  only data rows are written into it.


  Scenario: Using the has_header option
    Given the following command script:
    """
    file :items do
      has_header_row true

      field :id
      field :name
    end

    file :items_without_header do
      has_header_row false

      field :id
      field :name
    end

    file :items_copy do
      has_header_row true

      field :id
      field :name
    end

    transform :items => :items_without_header do |record|
      output record
    end

    transform :items_without_header => :items_copy do |record|
      output record
    end
    """
    And an "items.csv" file containing:
    """
    id,name
    1,data
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "items_without_header.csv" file containing:
    """
    1,data
    """
    And there should be an "items_copy.csv" file containing:
    """
    id,name
    1,data
    """

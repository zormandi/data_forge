Feature: Using the `output` command

  The `output` command in a transformation block writes the specified data (HasH) into the output file.
  Omitting this command conditionally for a row will skip the record and omitting it unconditionally will
  simply create an empty file without outputting any data into it.


  Background:
    Given an "items.csv" file containing:
    """
    id
    1
    2
    3
    """


  Scenario: Outputting arbitrary data as Hash
    Given the following command script:
    """
    file :items do
      field :id
    end

    file :books do
      field :author
      field :title
    end

    transform :items => :books do |record|
      output title: "Title #{record[:id]}",
             author: "Author #{record[:id]}"
    end
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "books.csv" file containing:
    """
    author,title
    Author 1,Title 1
    Author 2,Title 2
    Author 3,Title 3
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
    Then the process should exit successfully
    And there should be a "items_missing.csv" file containing:
    """
    id
    1
    3
    """


  Scenario: Multiple output commands multiply lines
    Given the following command script:
    """
    file :items do
      field :id
    end

    file :items_doubled do
      field :id
    end

    transform :items => :items_doubled do |record|
      output record
      output record
    end
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be a "items_doubled.csv" file containing:
    """
    id
    1
    1
    2
    2
    3
    3
    """

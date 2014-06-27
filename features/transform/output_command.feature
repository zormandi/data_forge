Feature: Using the `output` command

  The `output` command in a transformation block writes the specified data (HasH) into the output file.
  Omitting this command conditionally for a row will skip the record and omitting it unconditionally will
  simply create an empty file without outputting any data into it.


  Background:
    Given a file named "items.csv" with:
    """
    id
    1
    2
    3
    """


  Scenario: Outputting arbitrary data as Hash
    Given a file named "command_script.rb" with:
    """
    file :items do
      field :id
    end

    file :books do
      field :author
      field :title
    end

    transform :items, into: :books do |record|
      output title: "Title #{record[:id]}",
             author: "Author #{record[:id]}"
    end
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "books.csv" should exist
    And the file "books.csv" should contain exactly:
    """
    author,title
    Author 1,Title 1
    Author 2,Title 2
    Author 3,Title 3

    """


  Scenario: No output in transform block creates empty file
    Given a file named "command_script.rb" with:
    """
    file :items do
      field :id
    end

    file :items_empty do
      field :id
    end

    transform :items, into: :items_empty do end
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "items_empty.csv" should exist
    And the file "items_empty.csv" should be empty


  Scenario: Omitting output conditionally skips current record
    Given a file named "command_script.rb" with:
    """
    file :items do
      field :id
    end

    file :items_missing do
      field :id
    end

    transform :items, into: :items_missing do |record|
      output record unless "2" == record[:id]
    end
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "items_missing.csv" should exist
    And the file "items_missing.csv" should contain exactly:
    """
    id
    1
    3

    """


  Scenario: Multiple output commands multiply lines
    Given a file named "command_script.rb" with:
    """
    file :items do
      field :id
    end

    file :items_doubled do
      field :id
    end

    transform :items, into: :items_doubled do |record|
      output record
      output record
    end
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "items_doubled.csv" should exist
    And the file "items_doubled.csv" should contain exactly:
    """
    id
    1
    1
    2
    2
    3
    3

    """

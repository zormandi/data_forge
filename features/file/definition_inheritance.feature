Feature: File definition inheritance

  File definitions can be "inherited" using the `like` directive to the `file` command. The inherited structure
  can be further customized with the initialization block supplied to the `file` command.


  Scenario: Using the same definition
    Given a file named "command_script.rb" with:
    """
    file :items do
      field :id
      field :name
    end

    file :items_copy, like: :items

    transform :items, into: :items_copy do |record|
      output record
    end
    """
    And a file named "items.csv" with:
    """
    id,name
    Item1,Item name 1
    Item2,Item name 2
    Item3,Item name 3
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "items_copy.csv" should exist
    And the file "items_copy.csv" should contain exactly:
    """
    id,name
    Item1,Item name 1
    Item2,Item name 2
    Item3,Item name 3

    """


  Scenario: Customizing inherited definition
    Given a file named "command_script.rb" with:
    """
    file :items do
      field :id
      field :name
    end

    file :items_copy, like: :items do
      field :comment
      without_field :id
    end

    transform :items, into: :items_copy do |record|
      record[:comment] = "Just a comment"
      output record
    end
    """
    And a file named "items.csv" with:
    """
    id,name
    Item1,Item name 1
    Item2,Item name 2
    Item3,Item name 3
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "items_copy.csv" should exist
    And the file "items_copy.csv" should contain exactly:
    """
    name,comment
    Item name 1,Just a comment
    Item name 2,Just a comment
    Item name 3,Just a comment

    """

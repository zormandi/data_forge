Feature: Archiving file sources

  Scenario: Moving files to archive directory
    Given a file named "items1.csv" with:
    """
    id
    1
    """
    And a file named "items2.csv" with:
    """
    id
    2
    """
    And a file named "command_script.rb" with:
    """
    file :items1 do
      field :id
    end

    file :items2 do
      field :id
    end

    archive :items1, :items2, to: "archives", with_prefix: "arc_", with_suffix: "_new"
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a directory named "archives" should exist
    And the following files should exist:
      | archives/arc_items1_new.csv |
      | archives/arc_items2_new.csv |
    But the following files should not exist:
      | items1.csv |
      | items2.csv |
    And the file "archives/arc_items1_new.csv" should contain exactly:
    """
    id
    1
    """
    And the file "archives/arc_items2_new.csv" should contain exactly:
    """
    id
    2
    """

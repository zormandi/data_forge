Feature: Archiving file sources

  Background:
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


  Scenario: Moving a single file to the archives, creating the archive directory on-the-fly
    Given a file named "command_script.rb" with:
    """
    file :items1 do end

    archive :items1, to: "archives", as: "archived_items1"
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a directory named "archives" should exist
    And a file named "items1.csv" should not exist
    But a file named "archives/archived_items1.csv" should exist
    And the file "archives/archived_items1.csv" should contain exactly:
    """
    id
    1
    """


  Scenario: Moving a single file to the archives, using the original file name as the archive name
    Given a file named "command_script.rb" with:
    """
    file :new_items do
      file_name "items1.csv"
    end

    archive :new_items, to: "archives"
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "archives/items1.csv" should exist


  Scenario: Rolling up multiple files into one archive file and moving it to the archive directory
    Given a file named "command_script.rb" with:
    """
    file :items1 do end
    file :items2 do end

    archive :items1, :items2, to: "archives", as: "archived_items"
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And the following files should not exist:
      | items1.csv |
      | items2.csv |
    But a file named "archives/archived_items.tar" should exist
    And the "archives/archived_items.tar" archive should contain the following files:
      | items1.csv |
      | items2.csv |

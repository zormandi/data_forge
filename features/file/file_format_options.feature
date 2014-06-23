Feature: Formatting options for CSV files

  The `file` block offers options for setting the CSV file's delimiter character, quote character and encoding.
  All native Ruby encodings are supported.

  The default values are:
  - delimiter: ,
  - quote character: "
  - encoding: UTF-8


  Scenario: Using the default delimiter and quote character
    Given a file named "command_script.rb" with:
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
    And a file named "items.csv" with:
    """
    id,name,category
    1,"27"" screen",Screens
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "items_copy.csv" should exist
    And the file "items_copy.csv" should contain exactly:
    """
    id,name,category
    1,"27"" screen",Screens

    """


  Scenario: Using custom delimiter and quote character
    Given a file named "command_script.rb" with:
    """
    file :items do
      delimiter ";"
      quote "'"

      field :id
      field :name
      field :category
    end

    file :items_copy do
      delimiter "|"
      quote "`"

      field :id
      field :name
      field :category
    end

    transform :items => :items_copy do |record|
      output record
    end
    """
    And a file named "items.csv" with:
    """
    id;name;category
    1;'27'' screen';Screens
    2;24` screen;Screens
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "items_copy.csv" should exist
    And the file "items_copy.csv" should contain exactly:
    """
    id|name|category
    1|27' screen|Screens
    2|`24`` screen`|Screens

    """


  Scenario: Using custom encoding
    Given a file named "command_script.rb" with:
    """
    file :items do
      encoding "UTF-8"

      field :id
      field :name
      field :category
    end

    file :items_latin2 do
      encoding "ISO-8859-2"

      field :id
      field :name
      field :category
    end

    file :items_copy do
      encoding "UTF-8"

      field :id
      field :name
      field :category
    end

    transform :items => :items_latin2 do |record|
      output record
    end

    transform :items_latin2 => :items_copy do |record|
      output record
    end
    """
    And a file named "items.csv" with:
    """
    id,name,category
    1,Képernyő,Screens
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And the following files should exist:
      | items_latin2.csv |
      | items_copy.csv   |
    And the file "items_latin2.csv" should contain in "ISO-8859-2" encoding exactly:
    """
    id,name,category
    1,Képernyő,Screens

    """
    And the file "items_copy.csv" should contain in "UTF-8" encoding exactly:
    """
    id,name,category
    1,Képernyő,Screens

    """

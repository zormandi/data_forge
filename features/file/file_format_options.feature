Feature: Formatting options for CSV files

  The `file` block offers options for setting the CSV file's delimiter character, quote character and encoding.
  All native Ruby encodings are supported.

  The default values are:
  - delimiter: ,
  - quote character: "
  - encoding: UTF-8


  Scenario: Using the default delimiter and quote character
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
    1,"27"" screen",Screens
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "items_copy.csv" file containing:
    """
    id,name,category
    1,"27"" screen",Screens
    """


  Scenario: Using custom delimiter and quote character
    Given the following command script:
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
    And an "items.csv" file containing:
    """
    id;name;category
    1;'27'' screen';Screens
    2;24` screen;Screens
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "items_copy.csv" file containing:
    """
    id|name|category
    1|27' screen|Screens
    2|`24`` screen`|Screens
    """


  Scenario: Using custom encoding
    Given the following command script:
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
    And an "items.csv" file containing:
    """
    id,name,category
    1,Képernyő,Screens
    """
    When the command script is executed
    Then the process should exit successfully
    And there should be an "ISO-8859-2" encoded "items_latin2.csv" file containing:
    """
    id,name,category
    1,Képernyő,Screens
    """
    And there should be a "UTF-8" encoded "items_copy.csv" file containing:
    """
    id,name,category
    1,Képernyő,Screens
    """

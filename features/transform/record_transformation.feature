Feature: Transforming the record

  The `transform` block is passed the current record of the file that is being read. This record is a Hash with
  its keys defined in the corresponding `file` definition and its values read from the input file. The record
  can be transformed arbitrarily with pure Ruby code. The `output` command will write the record to file
  using only the keys that are defined in the `file` definition of the transformation's target file.


  Scenario: Using the record as a Hash
    Given a file named "command_script.rb" with:
    """
    file :products do
      field :id
      field :name
      field :main_category
      field :subcategory
    end

    file :transformed_products do
      field :item
      field :title
      field :category
    end

    transform :products, into: :transformed_products do |record|
      record[:item] = record[:id]
      record[:title] = record[:name].upcase
      record[:category] = [record[:main_category], record[:subcategory]].join " > "
      output record
    end
    """
    And a file named "products.csv" with:
    """
    id,name,main_category,subcategory
    IE-123,first product,Main category,Subcategory
    TM-234,second product,Group,Subgroup
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "transformed_products.csv" should exist
    And the file "transformed_products.csv" should contain exactly:
    """
    item,title,category
    IE-123,FIRST PRODUCT,Main category > Subcategory
    TM-234,SECOND PRODUCT,Group > Subgroup

    """

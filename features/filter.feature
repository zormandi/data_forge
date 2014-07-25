Feature: Filtering records of a file

  The `filter` command is useful for discarding records from a file that match the given criteria.

  It takes two parameters:
  1. The name of the input file to filter. (mandatory)
  2. `into:` The name of the output file. (optional) If not specified, the input file is overwritten.


  Scenario: Successful execution
    Given a file named "command_script.rb" with:
    """
    file :orders do
      field :id
      field :status
    end

    file :shipped_orders do
      field :id
    end

    filter :orders, into: :shipped_orders do |record|
      record[:status] == "SHIPPED"
    end
    """
    And a file named "orders.csv" with:
    """
    id,status
    1,SHIPPED
    2,PLACED
    3,READY_TO_SHIP
    4,SHIPPED
    5,RETURNED
    """
    When I run `forge command_script.rb`
    Then the exit status should be 0
    And a file named "shipped_orders.csv" should exist
    And the file "shipped_orders.csv" should contain exactly:
    """
    id
    1
    4

    """

require 'test_helper'

class DataImporterTest < ActiveSupport::TestCase
  def setup
    @data_file = File.open( File.join(Rails.root, "test", "fixtures", "example_input.tab") )
  end

  test "each row is imported" do
    assert_difference("Order.count", 2) do
      DataImporter.process(@data_file)
    end
  end

  test "all columns are imported" do
    import = DataImporter.process(@data_file)
    order  = import.orders.first

    assert_equal "Snake Plissken"      , order.purchaser_name   , 'imports purchaser name'
    assert_equal "$10 off $20 of food" , order.item_description , 'imports item description'
    assert_equal 10.0                  , order.item_price       , 'imports item price'
    assert_equal 2                     , order.purchase_count   , 'imports puchase count'
    assert_equal "987 Fake St"         , order.merchant_address , 'imports merchant address'
    assert_equal "Bob's Pizza"         , order.merchant_name    , 'imports merchant name'
  end
end

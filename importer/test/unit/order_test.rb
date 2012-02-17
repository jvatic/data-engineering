require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  def create_order(attributes)
    Order.create({
      :purchaser_name   => "John Doe",
      :item_description => "Some awesome product!",
      :item_price       => 2.00,
      :purchase_count   => 1,
      :merchant_address => "123 Fake st",
      :merchant_name    => "Joe's Bakery"
    }.merge(attributes))
  end

  def setup
    @orders = [
      create_order(:item_price => 10.0,  :purchase_count => 2),
      create_order(:item_price => 12.50, :purchase_count => 4)
    ]
  end

  test "Order.revenue_for(orders) returns gross revenue of given orders" do
    assert_equal 70.0, Order.revenue_for(@orders), '10x2 + 12.50x4 = 70'
  end

end

class Order < ActiveRecord::Base

  def self.revenue_for(orders)
    orders.inject(0) { |sum, order| sum + (order.purchase_count * order.item_price) }
  end

end

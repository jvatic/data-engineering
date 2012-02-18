module OrdersHelper
  def orders_revenue(orders)
    Order.revenue_for(orders)
  end
end

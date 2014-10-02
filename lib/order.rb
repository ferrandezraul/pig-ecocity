require 'product'
require 'customer'

class Order
  attr_reader :customer
  attr_reader :order_items

  def initialize(customer, order_items)
    @customer = customer
    @order_items = order_items
  end

  def to_s
    "Customer: #{@customer.name} \nItems: #{@order_items.to_s}"
  end

end
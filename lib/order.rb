require 'product'
require 'customer'

class Order
  attr_reader :customer
  attr_reader :order_items

  def initialize(customer, order_items)
    @customer = customer
    @order_items = order_items.dup
  end

  def to_s
    items = "Productes: \n"
    @order_items.each do |item |
      items += "#{item.to_s}\n"
    end
    "Client: #{@customer.name} \n#{ items }"
  end

end
require 'product'
require 'customer'

class Order
  attr_reader :customer
  attr_reader :order_items
  attr_reader :date

  def initialize(customer, order_items, date)
    @customer = customer
    @order_items = order_items.dup
    @date = date
  end

  def to_s
    items = "Productes: \n"
    @order_items.each do |item |
      items += "#{item.to_s}\n"
    end
    "Date: #{@date.to_s}\nClient: #{@customer.name} \n#{ items }"
  end

end
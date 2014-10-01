require 'product'
require 'customer'

class Order
  attr_reader :customer
  attr_reader :product
  attr_reader :quantity
  attr_reader :weight

  def initialize(customer, product, quantity, weight)
    @customer = customer
    @product = product
    @quantity = quantity
    @weight = weight
  end

  def to_s
    "Customer: #{@customer.name} \nQuantity: #{@quantity} \nWeight: #{@weight} \nProduct: #{@product.name}"
  end

end
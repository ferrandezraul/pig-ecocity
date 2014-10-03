require 'product'
require 'customer'

class OrderItem
  attr_reader :product
  attr_reader :quantity
  attr_reader :weight

  def initialize(product, quantity, weight)
    @product = product
    @quantity = quantity
    @weight = weight
  end

  def to_s
    "#{@quantity.to_i} x #{@weight.to_i} kg #{@product.to_s}"
  end

end
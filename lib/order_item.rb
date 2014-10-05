require 'product'
require 'customer'

class OrderItem
  attr_reader :product
  attr_reader :quantity
  attr_reader :weight

  def initialize(product, quantity, weight, observations)
    @product = product
    @quantity = quantity
    @weight = weight
    @observations = observations
  end

  def to_s
    if @observations.empty?
      "#{@quantity.to_i} x #{@weight.to_i} kg #{@product.to_s}"
    else
      "#{@quantity.to_i} x #{@weight.to_i} kg #{@product.to_s}\nObservacions: #{@observations.to_s}"
    end
  end

end
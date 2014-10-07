require 'product'
require 'customer'

class OrderItem
  attr_reader :product
  attr_reader :quantity
  attr_reader :weight
  attr_reader :observations

  def initialize(product, quantity, weight, observations)
    @product = product
    @quantity = quantity
    @weight = weight
    @observations = observations
  end

  def to_s
    if has_observations?
      "#{@quantity.to_i} x #{@weight.to_f} kg #{@product.to_s}\nObservacions: #{@observations.to_s}"
    else
      "#{@quantity.to_i} x #{@weight.to_f} kg #{@product.to_s}"
    end
  end

  def has_observations?
    if @observations.empty?
      false
    else
      true
    end
  end

end
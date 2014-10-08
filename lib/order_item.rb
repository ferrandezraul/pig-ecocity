require 'product'
require 'customer'

class OrderItem
  attr_reader :product
  attr_reader :quantity
  attr_reader :weight
  attr_reader :observations
  attr_reader :price

  def initialize(customer, product, quantity, weight, observations)
    @product = product
    @quantity = quantity
    @weight = weight
    @observations = observations
    @price = calculate_price(customer.type)
  end

  def to_s
    if has_observations?
      "#{@quantity.to_i} x #{'%.3f' % @weight.to_f} kg #{@product.name} = #{'%.2f' % @price} EUR\nObservacions: #{@observations.to_s}"
    else
      "#{@quantity.to_i} x #{'%.3f' % @weight.to_f} kg #{@product.name} = #{'%.2f' % @price} EUR"
    end
  end

  def has_observations?
    if @observations.empty?
      false
    else
      true
    end
  end

  private

  def calculate_price(customer_type)
    raise "Wrong customer type found" unless customer_type =~ /CLIENT|COOPE|TIENDA/

    total = 0
    case customer_type
      when "CLIENT"
        total += @quantity * @weight * @product.price_pvp
      when "COOPE"
        total += @quantity * @weight * @product.price_coope
      when "TIENDA"
        total += @quantity * @weight * @product.price_tienda
      else
        total += 0
    end

    total
  end

end
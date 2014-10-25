require 'product'
require 'customer'

class Order
  attr_reader :customer
  attr_reader :order_items
  attr_reader :date
  attr_reader :total

  def initialize(customer, date, order_items=[])
    @customer = customer
    @order_items = order_items.dup
    @date = date

    @total = calculate_total
  end

  def <<(order_item)
    @order_items << order_item
    @total = calculate_total
  end

  def to_s
    items = "Productes: \n"
    @order_items.each do |item |
      items += "#{item.to_s}\n"
    end
    "#{@date.to_s} #{@customer.name} \n#{@customer.address}\n#{ items }TOTAL = #{ '%.2f' % @total } EUR"
  end

  # Returns number of times a product has been ordered
  def times_ordered( product_name )
    ordered = 0
    @order_items.each do |item|
      if item.product.name == product_name
        ordered += 1
      end
    end
    ordered
  end

  # Returns number of times a product has been ordered
  def kg_ordered( product_name )
    ordered = 0
    @order_items.each do |item|
      if item.product.name == product_name
        ordered += item.weight
      end
    end
    ordered
  end

  # Returns number of times a product has been ordered
  def euros_ordered( product_name )
    euros_ordered = 0
    @order_items.each do |item|
      if item.product.name == product_name
        euros_ordered += item.price
      end
    end
    euros_ordered
  end

  def calculate_total
    total = 0
    @order_items.each do |item|
      total += item.price
    end
    total
  end

  def self.attributes_valid?( customer, product, quantity, peso )
    begin
      !Float(quantity)
    rescue
      alert "Quantitat ha de ser un numero"
      return false
    end

    if !product.has_subproducts?
      begin
        !Float(peso)
      rescue
        alert "Pes ha de ser un numero en kg"
        return false
      end
    end

    if quantity.to_i <= 0
      alert "Quantitat ha de ser mes gran que 0"
      return false
    end
    if product.nil?
      alert "Selecciona un producte."
      return false
    end
    if customer.nil?
      alert "Selecciona un client"
      return false
    end
    if customer.name.empty?
      alert "Selecciona un client"
      return false
    end
    true
  end

end
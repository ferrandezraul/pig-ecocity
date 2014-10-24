$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class NewOrderItemPanel < Shoes::Widget
  def initialize( args )
    products = args[:products]
    customer = args[:customer]
    product_names = ProductHelper.names(products)
    selected_product = nil
    order_item = nil
    observations = String.new
    quantity = 0
    weight = 0

    stack :margin => 4, :width => 260 do
      border black
      para "Producte:", :margin => 4
      list_box items: product_names, :margin => 4 do |list|
        selected_product = ProductHelper.find_product_with_name( products, list.text )
      end

      para "Observacions:", :margin => 4
      edit_line :margin => 4 do |line|
        observations = line.text
      end

      para "Quantitat:", :margin => 4
      edit_line :margin => 4 do |cantidad|
        quantity = cantidad.text.to_i
      end

      para "Pes en Kg: (0.2 = 200g.)", :margin => 4
      flow do
        edit_line :margin => 4 do |peso|
          weight = peso.text.to_f
        end
        para "Kg", :margin => 2
      end

      button "Afegir Producte", :margin => 4 do
        if valid_parameters?( selected_product, quantity, weight )
          order_item = OrderItem.new( customer, selected_product, quantity, weight, observations, [ ] )
        end
        yield order_item
      end
    end

  end

  private

  def valid_parameters?(product, quantity, weight)
    if product.nil?
      alert "Selecciona un producte."
      return false
    elsif quantity.zero?
      alert "Quantitat incorrecte"
      return false
    elsif weight.zero?
      alert "Pes incorrecte"
      return false
    end

    return true

  end
end
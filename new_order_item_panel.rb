# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'sub_products_panel'

class NewOrderItemPanel < Shoes::Widget
  def initialize( args )
    @products = args[:products]
    @customer = args[:customer]
    @selected_product = nil
    @selected_product_options = Array.new
    @order_item = nil
    @observations = String.new
    @quantity = 0
    @weight = 0

    stack :margin => 4 do
      border black
      para "Producte:", :margin => 4
      list_box items: ProductHelper.names(@products), :margin => 4 do |list|
        @selected_product = ProductHelper.find_product_with_name( @products, list.text )

        if @selected_product.has_options?
          @gui_subproducts_panel.clear do
            sub_products_panel( :subproducts => @selected_product.options ) do |product_options|
              @selected_product_options = product_options
            end
          end

        else
          @selected_product_options.clear
          @gui_subproducts_panel.clear
        end

        # Set default weight if available
        if @selected_product.weight_per_unit
          @gui_weight.text = "#{'%.3f' % @selected_product.weight_per_unit.to_f }"
        else
          @gui_weight.text = String.new
        end

      end

      @gui_subproducts_panel = stack :margin => 4

      para "Observacions:", :margin => 4
      edit_line :margin => 4 do |line|
        @observations = line.text
      end

      para "Quantitat:", :margin => 4
      @gui_quantity = edit_line :margin => 4 do |cantidad|
        @quantity = cantidad.text.to_i

        # Update default weight if available
        if @selected_product.weight_per_unit
          @gui_weight.text = "#{'%.3f' % ( @selected_product.weight_per_unit.to_f * @quantity ) }"
          @weight = @gui_weight.text.to_f
        end
      end

      para "Pes en Kg: (0.2 = 200g.)", :margin => 4
      flow do
        @gui_weight = edit_line :margin => 4 do |peso|
          @weight = peso.text.to_f
        end
        para "Kg", :margin => 2
      end

      button "Afegir Producte", :margin => 4 do
        if valid_parameters?( @selected_product, @quantity, @weight, @selected_product_options )
          @order_item = OrderItem.new( @customer, @selected_product, @quantity, @weight, @observations, @selected_product_options )
        end
        yield @order_item
      end
    end

  end

  private

  def valid_parameters?(product, quantity, weight, selected_subproducts)
    if product.nil?
      alert "Selecciona un producte."
      return false
    elsif quantity.zero?
      alert "Quantitat incorrecte"
      return false
    elsif weight.zero? and product.price_type == Product::PriceType::POR_KILO
      alert "Pes incorrecte"
      return false
    elsif weight != 0 and product.price_type == Product::PriceType::POR_UNIDAD
      alert "Pes incorrecte. Aquest producte es compra per unitats."
      return false
    elsif product.options.any? and selected_subproducts.empty?
      alert "Has de afegir els subproductes del lot per poder afegir un lot"
      return false
    end

    true

  end
end
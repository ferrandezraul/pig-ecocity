$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'products_view'
require 'product_helper'
require 'customer_helper'
require 'order.rb'
require 'order_item.rb'
require 'date_customer_dialog'

class NewOrderPanel < Shoes::Widget

  def initialize( products, customers, orders )
    reset_selected_product

    @products = products
    @customers = customers
    @orders = orders
    @product_names = ProductHelper.names(@products)
    @customer_names = CustomerHelper.names(@customers)

    select_date_and_customer
  end

  private

  # Enter date and customer
  # Sets @date and @selected_customer
  def select_date_and_customer
    date_customer_dialog items: @customers, :margin => 4 do |customer, date|
      if customer.nil?
        debug( "In new order dialog selected customer is nil")
      end

      if date.nil?
        debug( "In new order dialog date is nil")
      end

      if customer
        @order = Order.new( customer, date )
        select_product
      end
    end
  end

  # Enter product
  # Sets @selected_product, @observations, @quantity and @weight
  def select_product
    clear do
      flow :margin => 4 do
        print_select_product_dialog
        print_current_order_details
      end
    end
  end

  # Validates @selected_product, @quantity and @weight
  def valid_parameters?
    if @selected_product.nil?
      alert "Selecciona un producte"
      return false
    elsif @quantity == 0
      alert "Quantitat ha de ser un numero"
      return false
    elsif @weight == 0
      alert "Pes ha de ser un numero en kg"
      return false
    end

    return true
  end

  def add_order_item_to_order
    @order << OrderItem.new( @selected_customer, @selected_product, @quantity, @weight, @observations, [ ] )
  end

  def print_select_product_dialog
    stack :margin => 4, :width => 260 do
      border black
      para "Producte:", :margin => 4
      list_box items: @product_names, :margin => 4 do |list|
        @selected_product = ProductHelper.find_product_with_name( @products, list.text )
      end

      para "Observacions:", :margin => 4
      edit_line :margin => 4 do |line|
        @observations = line.text
      end

      para "Quantitat:", :margin => 4
      edit_line :margin => 4 do |quantity|
        @quantity = quantity.text.to_i
      end

      para "Pes en Kg: (ex. 0.2 = 200g.)", :margin => 4
      flow do
        edit_line :margin => 4 do |weight|
          @weight = weight.text.to_f
        end
        para "Kg", :margin => 2
      end

      button "Afegir Producte", :margin => 4 do
        if valid_parameters?
          add_order_item_to_order
          reset_selected_product
          select_product
        end
      end
    end
  end

  def print_current_order_details
    stack :margin => 4, :width => -260 do
      para @order.customer.name, :margin => 4
      para @order.customer.address, :margin => 4

      @order.order_items.each do |item|
        para item, :margin => 4
      end
    end
  end

  def reset_selected_product
    @selected_product = nil
    @weight = 0
    @observations = ""
    @quantity = 0
  end

end
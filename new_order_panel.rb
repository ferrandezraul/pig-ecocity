$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'products_view'
require 'product_helper'
require 'customer_helper'
require 'order.rb'
require 'order_item.rb'

class NewOrderPanel < Shoes::Widget

  def initialize( products, customers, orders )
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
    stack :margin => 4 do
      border black
      para "Data:", :margin => 4
      @date = "#{Date.today.to_s}"
      edit_line "#{Date.today.to_s}", :margin => 4 do |line|
        @date = line.text
      end

      para "Client:", :margin => 4
      list_box items: @customer_names, :margin => 4 do |list|
        @selected_customer = CustomerHelper.find_customer_with_name( @customers, list.text)
      end

      button "Acceptar", :margin => 4 do
        alert "Selecciona un client." unless @selected_customer

        if @selected_customer
          @order = Order.new( @selected_customer, @date )
          select_product
        end
      end
    end
  end

  # Enter product
  # Sets @selected_product, @observations, @quantity and @weight
  def select_product
    clear do
      border black
      stack :margin => 4 do
        para "Producte:", :margin => 4
        list_box items: @product_names, :margin => 4 do |list|
          @selected_product = ProductHelper.find_product_with_name( @products, list.text )
        end

        @observations = ""
        para "Observacions:", :margin => 4
        edit_line :margin => 4 do |line|
          @observations = line.text
        end

        @quantity = 0
        para "Quantitat:", :margin => 4
        edit_line :margin => 4 do |quantity|
          @quantity = quantity.text.to_i
        end

        @weight = 0
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
          end
        end
      end

      print_current_order_details
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
    # read @selected_product, @observations, @quantity and @weight and create order item, add to @order and update display by calling again select_product

    @order << OrderItem.new( @selected_customer, @selected_product, @quantity, @weight, @observations, [ ] )

    select_product
  end


  def print_current_order_details
    stack :margin => 4 do
      para @order.customer.name, :margin => 4
      para @order.customer.address, :margin => 4

      para @order.order_items, :margin => 4
    end
  end

end
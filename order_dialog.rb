$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_helper'
require 'customer_helper'

class OrderDialog

  def initialize( app, products, customers, orders )
    @app = app
    @orders = orders
    @products = products
    @customers = customers
    @gui_product_names = ProductHelper.names(products)
    @gui_customer_names = CustomerHelper.names(customers)

    @app.flow :margin => 4 do
      @app.border "#CD9"

      # This stack is 230 pixels wide
      # width needed to create 2 columns. See http://shoesrb.com/manual/Rules.html
      @app.stack :margin => 4, :width => 230 do
        @app.border "#CD9"
        @app.para "Data:", :stroke => "#CD9", :margin => 4
        gui_date = @app.edit_line :margin => 4
        gui_date.text = Date.today.to_s
        @app.para "Selecciona el client:", :stroke => "#CD9", :margin => 4
        customer_name = @app.list_box items: @gui_customer_names, :margin => 4
        @app.para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
        product_name = @app.list_box items: @gui_product_names, :margin => 4
        @app.para "Observacions:", :stroke => "#CD9", :margin => 4
        gui_observations = @app.edit_line items: @gui_customer_names, :margin => 4
        @app.para "Selecciona quantitat:", :stroke => "#CD9", :margin => 4
        quantity = @app.edit_line :margin => 4
        @app.para "Selecciona el pes en Kg:", :stroke => "#CD9", :margin => 4
        peso = @app.edit_line :margin => 4

        ordered_items = []

        @app.button "Agegir Producte", :margin => 10 do
          if Order.attributes_valid?( customer_name.text, product_name.text, quantity.text, peso.text )
            product = ProductHelper.find_product_with_name( @products, product_name.text )
            customer = CustomerHelper.find_customer_with_name( @customers, customer_name.text )
            ordered_items << OrderItem.new( customer, product, quantity.text.to_i, peso.text.to_f, gui_observations.text )
            print_ordered_items ordered_items
            debug( "Product #{product_name.text} added to order." )
          end
        end

        @app.button "Crear comanda", :margin => 10 do
          if ordered_items.empty?
            alert "Ha de afegir un producte per poder realitzar una comanda."
            return
          end
          create_order( customer_name.text, ordered_items, gui_date.text )
          alert "Comanda afegida!"
          @gui_text_order_items.clear{ @app.stack :margin => 4, :width => -230 }
          ordered_items.clear
          gui_observations.text = ""
          debug( "Order for #{customer_name.text} added." )
        end

      end

      # @gui_text_order_items is a stack 100% minus 230 pixels wide
      @gui_text_order_items = @app.stack :margin => 4, :width => -230 do
        @app.border "#CD9"
      end
    end
  end

  private

  def create_order(customer_name, order_items, date_string )
    customer = CustomerHelper.find_customer_with_name( @customers, customer_name )
    @orders << Order.new( customer, order_items, date_string )
  end

  def print_ordered_items ordered_items
    @gui_text_order_items.clear {
      @app.border "#CD9"
      total = 0
      ordered_items.each do |item|
        total += item.price
        @app.para "#{item.to_s}", :stroke => "#CD9", :margin => 4, :align => 'right'
      end
      @app.para @app.strong( "TOTAL = #{'%.2f' % total} EUR"), :stroke => "#CD9", :margin => 8, :align => 'right'
    }
  end
end
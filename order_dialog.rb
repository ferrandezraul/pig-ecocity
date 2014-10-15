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
        @app.para "Client:", :stroke => "#CD9", :margin => 4
        customer_name = @app.list_box items: @gui_customer_names, :margin => 4
        @app.para "Producte:", :stroke => "#CD9", :margin => 4

        product_name = @app.list_box items: @gui_product_names, :margin => 4 do |list|
          product = ProductHelper.find_product_with_name( @products, list.text )
          if product.has_subproducts?
            subproducts = product.subproducts
            @gui_subproducts.clear{
              @app.para "Choose subproducts:", :stroke => "#CD9", :margin => 4
              subproducts.each do |subproduct|
                @app.para "#{subproduct[:name]}", :stroke => "#CD9", :margin => 4
              end
            }
          else
            @gui_subproducts.clear
          end
        end

        # @gui_text_order_items is a stack 100% minus 230 pixels wide
        @gui_subproducts = @app.stack :margin => 4

        @app.para "Observacions:", :stroke => "#CD9", :margin => 4
        gui_observations = @app.edit_line items: @gui_customer_names, :margin => 4
        @app.para "Quantitat:", :stroke => "#CD9", :margin => 4
        quantity = @app.edit_line :margin => 4
        @app.para "Pes en Kg: (exemple 0.2 = 200g.)", :stroke => "#CD9", :margin => 4
        weigh = @app.edit_line :margin => 4

        @ordered_items = []

        @app.button "Afegir Producte", :margin => 10 do
          add_item_to_ordered_items( customer_name.text, product_name.text, quantity.text, weigh.text, gui_observations.text )
          @gui_text_order_items.clear { print_items( @ordered_items ) }
        end

        @app.button "Crear comanda", :margin => 10 do
          if @ordered_items.empty?
            alert "Ha de afegir un producte per poder realitzar una comanda."
          else
            create_order( customer_name.text, @ordered_items, gui_date.text )
            alert "Comanda afegida!"
            @gui_text_order_items.clear{ @app.stack :margin => 4, :width => -230 }
            @ordered_items.clear
            gui_observations.text = ""
            debug( "Order for #{customer_name.text} added." )
          end
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

  def print_items(items)
    @app.border "#CD9"
    total = 0
    items.each do |item|
      total += item.price
      @app.flow do
        @app.stack :width => -110, :margin => 4 do
          @app.para "#{item.to_s}", :stroke => "#CD9", :margin => 4, :align => 'right'
        end
        @app.stack :width => 110 do
          @app.button "Eliminar", :margin => 4 do
            delete(item)
            debug("Deleted #{item.product.name} from order.")
          end
        end
      end

    end
    @app.para @app.strong( "TOTAL = #{'%.2f' % total} EUR"), :stroke => "#CD9", :margin => 8, :align => 'right'
  end

  def delete(item)
    @ordered_items.delete(item)
    debug("Deleted #{item.product.name} from order.")
    @gui_text_order_items.clear { print_items( @ordered_items ) }
  end

  def add_item_to_ordered_items( customer_name, product_name, quantity, weigh, gui_observations )
    if Order.attributes_valid?( customer_name, product_name, quantity, weigh )
      product = ProductHelper.find_product_with_name( @products, product_name )
      customer = CustomerHelper.find_customer_with_name( @customers, customer_name )
      @ordered_items << OrderItem.new( customer, product, quantity.to_i, weigh.to_f, gui_observations )
      debug( "Product #{product_name.text} added to order from #{customer_name.text}." )
    end
  end


end
# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'
require 'customer_helper'
require 'product_helper'
require 'order'
require 'order_item'
require 'table'

def products_csv__path
  return ::File.join( File.dirname( __FILE__ ), "csv/products.csv" )
end

def customers_csv__path
  return ::File.join( File.dirname( __FILE__ ), "csv/customers.csv" )
end

def load_products
  debug( "Loading Products ..." )
  begin
    ProductCSV.read( products_csv__path )
  rescue Errors::ProductCSVError => e
    alert e.message
  end
end

def load_customers
  debug( "Loading Customers ..." )
  begin
    CustomerCSV.read( customers_csv__path )
  rescue Errors::CustomersCSVError => e
    alert e.message
  end
end

Shoes.app :width => 1000, :height => 700 do
  background "#555"

  @title = "Ecocity Porc"

  def new_order_dialog
    flow do
      border red
      @gui_text_order_items = stack :margin => 4, :width => 500
      stack :margin => 4, :width => 250 do
        border yellow
        para "Data:", :stroke => "#CD9", :margin => 4
        gui_date = edit_line :margin => 4
        gui_date.text = Date.today.to_s
        para "Selecciona el client:", :stroke => "#CD9", :margin => 4
        customer_name = list_box items: @gui_customer_names, :margin => 4
        para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
        product_name = list_box items: @gui_product_names, :margin => 4
        para "Observacions:", :stroke => "#CD9", :margin => 4
        gui_observations = edit_line items: @gui_customer_names, :margin => 4
        para "Selecciona quantitat:", :stroke => "#CD9", :margin => 4
        quantity = edit_line :margin => 4
        para "Selecciona el pes en Kg:", :stroke => "#CD9", :margin => 4
        peso = edit_line :margin => 4

        ordered_items = []

        button "Agegir Producte", :margin => 10 do
          if Order.attributes_valid?( customer_name.text, product_name.text, quantity.text, peso.text )
            product = ProductHelper.find_product_with_name( @products, product_name.text )
            ordered_items << OrderItem.new( product, quantity.text.to_i, peso.text.to_f, gui_observations.text )
            print_ordered_items ordered_items
          end
        end

        button "Crear comanda", :margin => 10 do
          if ordered_items.empty?
            alert "Ha de afegir un producte per poder realitzar una comanda."
            return
          end
          create_order( customer_name.text, ordered_items, gui_date.text )
          alert "Comanda afegida!"
          @gui_text_order_items.clear
          ordered_items.clear
          gui_observations.text = ""
        end

      end
    end

  end

  def create_order(customer_name, order_items, date_string )
    customer = CustomerHelper.find_customer_with_name( @customers, customer_name )
    @orders << Order.new( customer, order_items, date_string )
  end

  def print_ordered_items ordered_items
    @gui_text_order_items.clear {
      border blue
      ordered_items.each do |item|
        para "#{item.quantity.to_i} x #{item.weight.to_f} kg #{item.product.to_s}", :stroke => "#CD9", :margin => 4
        if item.has_observations?
          para strong("Observacions: #{item.observations}"), :stroke => "#CD9", :margin => 4
        end
      end
    }
  end

  def resume_dialog
    stack :margin => 4 do
      para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
      list_box items: @gui_product_names do |product_name|
        times_ordered = 0
        kg_ordered = 0
        @orders.each do |order|
          times_ordered += order.times_ordered(product_name.text)
          kg_ordered += order.kg_ordered(product_name.text)
        end
        @gui_text_resume.clear {
          para "Ordered #{times_ordered.to_i} times\n", :stroke => "#CD9", :margin => 4
          para strong("Total #{kg_ordered.to_f} Kg\n"), :stroke => "#CD9", :margin => 4
        }
      end
      @gui_text_resume = flow
    end
  end

  stack :margin => 10 do
    title strong(@title), :align => "center", :stroke => "#DFA", :margin => 0

    @products = load_products
    @customers = load_customers
    @orders = []

    @gui_product_names = ProductHelper.names(@products)
    @gui_customer_names = CustomerHelper.names(@customers)

    flow :margin => 10 do
      button "Productes", :margin => 4 do
        @gui_main_window.clear{
          @products.each do |product|
            para "#{product.to_s}\n", :stroke => "#DFA", :align => "left"
          end
        }
      end

      button "Comandes", :margin => 4 do
        @gui_main_window.clear{
          @orders.each do |order|
            para "#{order.to_s}\n", :stroke => "#CD9", :margin => 4
          end
        }
      end

      button "Clients", :margin => 4 do
        @gui_main_window.clear{
          @customers.each do |customer|
            para "#{customer.to_s}\n", :stroke => "#CD9", :margin => 4
          end
        }
      end

      button "Nova Comanda", :margin => 4 do
        @gui_main_window.clear{
          new_order_dialog
        }
      end

      button "TOTAL", :margin => 4 do
        @gui_main_window.clear{
          resume_dialog
        }
      end

      # This is for clearing flow when user press any button
      # extracted from here http://ruby.about.com/od/shoes/ss/shoes3_2.htm
      @gui_main_window = flow
    end

  end
end
# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'
require 'customer_helper'
require 'product_helper'
require 'order'
require 'order_item'
require 'table'
require 'pig'
require 'order_dialog'

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

  def resume_dialog
    flow :margin => 4 do

      # stack 230 pixels wide
      stack :margin => 4, :width => 240 do
        border "#CD9"
        para "Porc restant", :stroke => "#CD9", :margin => 4
        para @pig.to_s, :stroke => "#CD9", :margin => 4
      end

      # stack 100% minus 230 pixels wide
      stack :margin => 4, :width => -240 do
        border "#CD9"
        para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
        list_box items: @gui_product_names, :margin => 4 do |product_name|
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
  end

  stack :margin => 10 do
    title strong(@title), :align => "center", :stroke => "#DFA", :margin => 0

    @products = load_products
    @customers = load_customers
    @orders = []
    @pig = Pig.new

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
          OrderDialog.new(self, @products, @customers, @orders)
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
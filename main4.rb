# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'
require 'customer_helper'
require 'product_helper'
require 'order'
require 'order_item'
require 'table'

Shoes.app :width => 1000, :height => 700 do
  background "#555"

  @title = "Ecocity Porc"

  def products_csv__path
    return ::File.join( File.dirname( __FILE__ ), "csv/products.csv" )
  end

  def customers_csv__path
    return ::File.join( File.dirname( __FILE__ ), "csv/customers.csv" )
  end

  def load_products
    debug( "Loading Products ..." )
    begin
      @products = ProductCSV.read( products_csv__path )
    rescue Errors::ProductCSVError => e
      alert e.message
    end
    @product_names = ProductHelper.names(@products)
  end

  def load_customers
    debug( "Loading Customers ..." )
    begin
      @customers = CustomerCSV.read( customers_csv__path )
    rescue Errors::CustomersCSVError => e
      alert e.message
    end
    @customer_names = CustomerHelper.names(@customers)
  end

  def new_order_dialog
    flow do
      border red
      @text_order_items = stack :margin => 4, :width => 500
      stack :margin => 4, :width => 250 do
        border yellow
        para "Selecciona el client:", :stroke => "#CD9", :margin => 4
        customer_name = list_box items: @customer_names, :margin => 4
        para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
        product_name = list_box items: @product_names, :margin => 4
        para "Selecciona quantitat:", :stroke => "#CD9", :margin => 4
        quantity = edit_line :margin => 4
        para "Selecciona el pes en grams:", :stroke => "#CD9", :margin => 4
        peso = edit_line :margin => 4

        ordered_items = []

        button "Agegir Producte", :margin => 10 do
          product = ProductHelper.find_product_with_name( @products, product_name.text )
          ordered_items << OrderItem.new( product, quantity.text.to_i, peso.text.to_i )
          print_ordered_items ordered_items
        end

        flow do
          button "Crear comanda", :margin => 10 do
            if order_attributes_valid?( customer_name.text, product_name.text, quantity.text, peso.text.to_i )
              customer = CustomerHelper.find_customer_with_name( @customers, customer_name.text )
              @orders << Order.new( customer, ordered_items )
              alert "Comanda afegida!"
              @text_order_items.clear
            end
          end
        end

      end
    end

  end

  def print_ordered_items ordered_items
    @text_order_items.clear {
      border blue
      ordered_items.each do |item|
        para "#{item.to_s}\n", :stroke => "#CD9", :margin => 4
      end
    }
  end

  def resume_dialog
    stack :margin => 4 do
      para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
      list_box items: @product_names do |product_name|
        ordered = 0
        @orders.each do |order|
          items = order.order_items
          items.each do |item|
            if item.product.name == product_name.text
              ordered += 1
            end
          end
        end
        @text_resume.clear { para "Ordered #{ordered.to_i} times", :stroke => "#CD9", :margin => 4 }
      end
      @text_resume = flow
    end
  end

  def order_attributes_valid?( customer_name, product_name, quantity, peso )
    begin
      !Float(quantity)
    rescue
      alert "Quantitat ha de ser un numero"""
      return false
    end

    if quantity.to_i <= 0
      alert "Quantitat ha de ser mes gran que 0"
      return false
    end
    if product_name.nil?
      alert "Selecciona un producte."
      return false
    end
    if product_name.empty?
      alert "Selecciona un producte."
      return false
    end
    if customer_name.nil?
      alert "Selecciona un client"
      return false
    end
    if customer_name.empty?
      alert "Selecciona un client"
      return false
    end
    true
  end

  stack :margin => 10 do
    title strong(@title), :align => "center", :stroke => "#DFA", :margin => 0

    load_products
    load_customers
    @orders = []

    flow :margin => 10 do
      button "Productes", :margin => 4 do
        @p.clear{
          @products.each do |product|
            para "#{product.to_s}\n", :stroke => "#DFA", :align => "left"
          end
        }
      end

      button "Comandes", :margin => 4 do
        @p.clear{
          @orders.each do |order|
            para "#{order.to_s}\n", :stroke => "#CD9", :margin => 4
          end
        }
      end

      button "Clients", :margin => 4 do
        @p.clear{
          @customers.each do |customer|
            para "#{customer.to_s}\n", :stroke => "#CD9", :margin => 4
          end
        }
      end

      button "Nova Comanda", :margin => 4 do
        @p.clear{
          new_order_dialog
        }
      end

      button "TOTAL", :margin => 4 do
        @p.clear{
          resume_dialog
        }
      end

      # This is for clearing flow when user press any button
      # extracted from here http://ruby.about.com/od/shoes/ss/shoes3_2.htm
      @p = flow
    end

  end
end
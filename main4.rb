# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'
require 'customer_helper'
require 'product_helper'
require 'order'
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
    stack :margin => 4 do
      para "Selecciona el client:", :stroke => "#CD9", :margin => 4
      customer_name = list_box items: @customer_names
      para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
      product_name = list_box items: @product_names
      para "Selecciona quantitat:", :stroke => "#CD9", :margin => 4
      quantity = edit_line
      para "Selecciona el pes en grams:", :stroke => "#CD9", :margin => 4
      peso = edit_line

      button "Crear comanda", :margin => 10 do
        if order_attributes_valid?( customer_name.text, product_name.text, quantity.text, peso.text.to_i )
          product = ProductHelper.find_product_with_name( @products, product_name.text )
          customer = CustomerHelper.find_customer_with_name( @customers, customer_name.text )

          @orders << ::Order.new( customer, product, quantity.text.to_i, peso.text.to_i )
          alert "Comanda afegida!"
        end
      end

    end
  end

  def resume_dialog
    stack :margin => 4 do
      para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
      list_box items: @product_names do |product_name|
        ordered = 0
        @orders.each do |order|
          if order.product.name == product_name.text
            ordered += 1
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
            para "\nComanda per #{order.customer.name}\n", :stroke => "#CD9", :margin => 4
            para "#{order.quantity.to_i} x #{order.weight.to_i} g. #{order.product.name}\n", :stroke => "#CD9", :margin => 4
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
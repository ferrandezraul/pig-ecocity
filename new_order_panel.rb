# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'products_view'
require 'product_helper'
require 'customer_helper'
require 'order.rb'
require 'order_item.rb'
require 'date_customer_dialog'
require 'new_order_item_panel'
require 'order_view'

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
  def select_date_and_customer
    date_customer_dialog items: @customers, :margin => 4 do |customer, date|
      if customer and !date.empty?
        @order = Order.new( customer, date )
        print
      end
    end
  end

  def print
    clear do
      flow :margin => 4 do
        stack :margin => 4, :width => 300 do
          print_select_product_dialog
        end
        stack :margin => 4, :width => -300 do
          print_current_order_details
        end
      end
    end
  end

  def print_select_product_dialog
    new_order_item_panel products: @products, customer: @order.customer do |order_item|
      if order_item
        @order << order_item
        print
      end
    end
  end

  def print_current_order_details
    # Include order view with its headers
    order_view( :order => @order, :headers => true, :delete_button => true )

    if @order.order_items.any?
      button "Crear comanda", :margin => 4 do
        @orders << @order
        clear do
          para "Comanda afegida."
        end
      end
    end
  end

end
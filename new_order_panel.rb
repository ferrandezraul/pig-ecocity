$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'products_view'
require 'product_helper'
require 'customer_helper'
require 'order.rb'
require 'order_item.rb'
require 'date_customer_dialog'
require 'new_order_item_panel'

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
        clear do
          flow :margin => 4 do
            @gui_order_details = print_select_product_dialog
            @gui_order_details = print_current_order_details
          end
        end
      end
    end
  end

  def print_select_product_dialog
    new_order_item_panel products: @products, customer: @order.customer do |order_item|
      if order_item
        @order << order_item
        @gui_order_details.clear{ print_current_order_details }
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

end
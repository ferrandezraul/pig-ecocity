#!/bin/env ruby
# encoding: utf-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'


PATH_TO_CSV = File.join( File.dirname( __FILE__ ), "products/products_original.csv" )

class Main < Shoes
  # Url method comes from Shoes
  url '/', :index        # draws page from the index method   (you can organise your methods in different classes)
  url '/products', :products   # draws page from the products method
  url '/orders', :orders   # draws page from the orders method
  url '/summary', :summary # draws page from the summary method
  url '/new_order', :new_order # draws page from the new_order method

  def index
    para link("Products\n", :click => "/products"),
         link("Orders\n", :click => "/orders"),
         link("Summary\n", :click => "/summary")
         link("New Order\n", :click => "/new_order")
  end

  def products
    para "Products:\n"

    @productos = ProductCSV.read( PATH_TO_CSV )

    @productos.each do |product|
      para "#{product[:name]} \n"
    end

    para link("Go back.", :click => "/")
  end

  def orders
    para "Orders in place:\n "

    para link("New Order\n", :click => "/new_order")

    para link("Go back.\n", :click => "/")
  end

  def summary
    para "Summary:\n ",
         link("Go back.\n", :click => "/")
  end

  def new_order
    para "New Order:\n"

    para link("Go back.\n", :click => "/")
  end

end

# Need this. That's what opens the window
Shoes.app :title => "Porc Ecocity", :width => 600, :height => 900
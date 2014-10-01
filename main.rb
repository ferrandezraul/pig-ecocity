#!/bin/env ruby
# encoding: utf-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'
require 'errors'

class Main < Shoes
  # Url method comes from Shoes
  url '/', :index        # draws page from the index method   (you can organise your methods in different classes)
  url '/products', :products   # draws page from the products method
  url '/customers', :customers   # draws page from the customers method
  url '/orders', :orders   # draws page from the orders method
  url '/summary', :summary # draws page from the summary method
  url '/new_order', :new_order # draws page from the new_order method

  def products_csv__path
    return ::File.join( File.dirname( __FILE__ ), "csv/products.csv" )
  end

  def customers_csv__path
    return ::File.join( File.dirname( __FILE__ ), "csv/customers.csv" )
  end

  def load_products
    begin
      @products = ::ProductCSV.read( products_csv__path )
    rescue ::Errors::ProductCSVError => e
      alert e.message
    end
  end

  def load_customers
    begin
      @customers = ::CustomerCSV.read( customers_csv__path )
    rescue ::Errors::CustomersCSVError => e
      alert e.message
    end
  end

  def index
    load_products
    load_customers

    para link("Products\n", :click => "/products"),
         link("Clients\n", :click => "/customers"),
         link("Orders\n", :click => "/orders"),
         link("Summary\n", :click => "/summary")
         link("New Order\n", :click => "/new_order")
  end

  def products
    para "Products:\n"

    load_products

    @products.each do |product|
      para "#{product.to_s} \n"
    end

    para link("Go back.", :click => "/")
  end

  def customers
    para "Clients:\n"

    load_customers

    @customers.each do |customer|
      para "#{customer.to_s} \n"
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
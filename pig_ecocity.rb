# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'
require 'order_csv'
require 'errors'
require 'menu_panel'

ORDERS_JSON_PATH = ::File.join( File.dirname( __FILE__ ), "csv/orders.json" )
PRODUCTS_CSV_PATH = ::File.join( File.dirname( __FILE__ ), "csv/products.csv" )
CUSTOMERS_CSV_PATH = ::File.join( File.dirname( __FILE__ ), "csv/customers.csv" )
ORDERS_CSV_PATH = ::File.join( File.dirname( __FILE__ ), "csv/orders.csv" )


def load_products
  debug( "Loading Products ..." )
  begin
    ProductCSV.read( PRODUCTS_CSV_PATH )
  rescue Errors::ProductCSVError => e
    alert e.message
  end
end

def load_customers
  debug( "Loading Customers ..." )
  begin
    CustomerCSV.read( CUSTOMERS_CSV_PATH )
  rescue Errors::CustomersCSVError => e
    alert e.message
  end
end

def load_orders(products, customers)
  debug( "Loading Orders ..." )
  begin
    OrderCSV.read( ORDERS_CSV_PATH, products, customers )
  rescue Errors::CustomersCSVError => e
    alert e.message
  end
end

Shoes.app :width => 1500, :height => 900 do

  title = "Porc Ecocity"

  # Execute ruby -v a print output into console
  #debug( %x[ruby -v] )

  stack :margin => 10 do
    title strong(title), :align => "center", :margin => 4

    products = load_products
    customers = load_customers
    #orders = load_orders(products, customers)
    orders = []

    menu_panel :products => products,
               :customers => customers,
               :orders => orders
  end

end

# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'

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

Shoes.app :width => 1000, :height => 900 do

  @title = "Ecocity Porc"

  stack :margin => 10 do
    title strong(@title), :align => "center", :margin => 0

    @products = load_products
    @customers = load_customers


  end

end
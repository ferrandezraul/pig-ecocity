$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'date_customer_dialog'
require 'customer_helper'
require 'customers_csv'
require 'customer'


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


Shoes.app :width => 600, :height => 130 do
  @products = load_products
  @customers = load_customers
  @product_names = ProductHelper.names(@products)



  date_customer_dialog items: @customers, :margin => 4 do |date, customer_name|
    para date
    para customer_name
  end

end

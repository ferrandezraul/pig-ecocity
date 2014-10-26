# encoding: UTF-8
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


Shoes.app :width => 900, :height => 600 do
  products = load_products
  border blue

  def headers
    flow :margin => 4 do
      stack :width => '25%' do
        para strong("NAME"), :margin => 4, :align => 'left'
      end
      stack :width => '25%' do
        para strong("TIENDA"), :margin => 4, :align => 'right'
      end
      stack :width => '25%' do
        para strong("COOPE"), :margin => 4, :align => 'right'
      end
      stack :width => '25%' do
        para strong("PVP"), :margin => 4, :align => 'right'
      end
    end
  end

  stack :margin => 4 do
    headers
    products.each do |product|
      flow :margin => 4 do
        stack :width => '25%' do
          para "#{product.name}", :margin => 4, :align => 'left'
        end
        stack :width => '25%' do
          para "#{ '%.2f' % product.price_tienda} €/KG", :margin => 4, :align => 'right'
        end
        stack :width => '25%' do
          para "#{ '%.2f' % product.price_coope} €/KG", :margin => 4, :align => 'right'
        end
        stack :width => '25%' do
          para "#{ '%.2f' % product.price_pvp} €/KG", :margin => 4, :align => 'right'
        end
      end
    end
  end

end

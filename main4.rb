# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'


Shoes.app :width => 800, :height => 600 do
  background "#555"

  @title = "Ecocity Porc"

  stack :margin => 10 do
    title strong(@title), :align => "center", :stroke => "#DFA", :margin => 0

    PATH_TO_PRODUCTS_CSV = ::File.join( File.dirname( __FILE__ ), "csv/products.csv" )
    PATH_TO_CUSTOMERS_CSV = ::File.join( File.dirname( __FILE__ ), "csv/customers.csv" )

    @products = ProductCSV.read( PATH_TO_PRODUCTS_CSV )
    @customers = CustomerCSV.read( PATH_TO_CUSTOMERS_CSV )
    @orders = []

    button "Productes" do
      @p.clear{
        @products.each do |product|
          para "#{product.to_s}\n", :stroke => "#CD9", :margin => 4
        end
      }
    end

    button "Comandes" do
      @p.clear{
        @orders.each do |order|
          para "#{order[:name]}\n", :stroke => "#CD9", :margin => 4
        end
      }
    end

    button "Clients" do
      @p.clear{
        @customers.each do |customer|
          para "#{customer[:name]}\n", :stroke => "#CD9", :margin => 4
        end
      }
    end

    @p = flow

  end
end
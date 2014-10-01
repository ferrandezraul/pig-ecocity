# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'


Shoes.app :width => 800, :height => 600 do
  background "#555"

  @title = "Ecocity Porc"

  def products_csv__path
    return ::File.join( File.dirname( __FILE__ ), "csv/products.csv" )
  end

  def customers_csv__path
    return ::File.join( File.dirname( __FILE__ ), "csv/customers.csv" )
  end

  def load_products
    begin
      @products = ProductCSV.read( products_csv__path )
    rescue Errors::ProductCSVError => e
      alert e.message
    end
  end

  def load_customers
    begin
      @customers = CustomerCSV.read( customers_csv__path )
    rescue Errors::CustomersCSVError => e
      alert e.message
    end
  end

  stack :margin => 10 do
    title strong(@title), :align => "center", :stroke => "#DFA", :margin => 0

    load_products
    load_customers

    @orders = []

    flow :margin => 10 do
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
            para "#{customer.to_s}\n", :stroke => "#CD9", :margin => 4
          end
        }
      end

      button "Nova Comanda" do
        @p.clear{
          para "Selecciona el client:", :stroke => "#CD9", :margin => 4
          client = list_box items: @customers
          para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
          product = list_box items: @products
          para "Selecciona la quantitat en grams:", :stroke => "#CD9", :margin => 4
          peso = edit_line.text.to_i
          peso = peso.to_f

        }
      end

      # This is for clearing flow when user press any button
      # extracted from here http://ruby.about.com/od/shoes/ss/shoes3_2.htm
      @p = flow

    end

  end
end
# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'


Shoes.app :width => 800, :height => 600 do
  background "#555"

  @title = "Ecocity Porc"

  stack :margin => 10 do
    title strong(@title), :align => "center", :stroke => "#DFA", :margin => 0
    para "Porc Ecocity", :align => "center", :stroke => "#DFA",
         :margin => 0

    PATH_TO_CSV = ::File.join( File.dirname( __FILE__ ), "products/products_original.csv" )
    @productos = ProductCSV.read( PATH_TO_CSV )
    @orders = []

    button "Productes" do
      @p.clear{
        @productos.each do |product|
          para product[:name], :stroke => "#CD9", :margin => 4
        end
      }
    end

    button "Comandes" do
      @p.clear{
        @orders.each do |order|
          para order[:name], :stroke => "#CD9", :margin => 4
        end
      }
    end

    @p = flow

  end
end
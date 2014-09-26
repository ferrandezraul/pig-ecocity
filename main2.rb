$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'

class ProductsView
  PATH_TO_CSV = File.join( File.dirname( __FILE__ ), "products/products_original.csv" )

  def initialize(app)
    @app = app

    @productos = ProductCSV.read( PATH_TO_CSV )

  end

  def draw
    draw_products
  end

  private

  def draw_products
    @app.stack do
      @app.para "PRODUCTOS\n"
      @productos.each do |product|
        @app.para "#{product[:name]} \n"
      end
    end
  end
end

Shoes.app( :title => "Porc Ecocity" ){
  my_view = ProductsView.new(self) # passing in the app here
  my_view.draw
}
$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ProductsView
  def initialize( app, products)
    @app = app
    @products = products

    @products.each do |product|
      @app.para "#{product.to_s}\n", :align => "left"
    end

  end

end
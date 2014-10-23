$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ProductsView < Shoes::Widget
  def initialize( products )
    stack do
      products.each do |product|
        para "#{product.to_s}"
      end
    end
  end
end
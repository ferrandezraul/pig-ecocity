$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ProductsView < Shoes::Widget
  def initialize( products )
    stack :margin => 4 do
      products.each do |product|
        para "#{product.to_s}", :margin => 4
      end
    end
  end
end
$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ProductsView
  def initialize( stack )
    @stack = stack

    @stack.app do
      clear
      @products.each do |product|
        para "#{product.to_s}\n", :align => "left"
      end
    end

  end

end
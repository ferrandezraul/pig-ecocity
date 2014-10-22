$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ProductsView
  def initialize( stack )
    @stack = stack

    # Call @stack.app in order to be able to access global @products and global @gui_main_window
    @stack.app do
      @gui_main_window.clear{
        @products.each do |product|
          para "#{product.to_s}\n", :align => "left"
        end
      }
    end

  end

end
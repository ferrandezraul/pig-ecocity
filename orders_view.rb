$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class OrdersView
  def initialize( stack )
    @stack = stack

    # Call @stack.app in order to be able to access global @orders and global @gui_main_window
    @stack.app do
      @gui_main_window.clear{
        @orders.each do |order|
          para "#{order.to_s}\n", :align => "left"
        end
      }
    end

  end

end
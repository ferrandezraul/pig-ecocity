$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class CustomersView
  def initialize( stack )
    @stack = stack

    # Call @stack.app in order to be able to access global @customers and global @gui_main_window
    @stack.app do
      @gui_main_window.clear{
        @customers.each do |customer|
          para "#{customer.to_s}\n", :align => "left"
        end
      }
    end

  end
end
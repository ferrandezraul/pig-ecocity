$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'date_dialog'

class NewOrderDialog
  def initialize( shoes_stack )
    @stack = shoes_stack

    # Call @stack.app in order to be able to access global @orders and global @gui_main_window
    @stack.app do
      @gui_main_window.clear{
        stack :margin => 4 do
          border black
          date_stack = stack :margin => 4
          date_dialog = DateDialog.new( date_stack )

          para "Client:", :margin => 4
          customer_name = list_box items: @customer_names, :margin => 4

          button "Acceptar", :margin => 4 do
            begin
              customer = CustomerHelper.find_customer_with_name( @customers, customer_name.text)
            rescue Errors::CustomerHelperError
              alert "Selecciona un client"
            end

            # TODO create new dialog for items
          end
        end
      }
    end

  end

end
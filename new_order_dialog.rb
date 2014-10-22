$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class NewOrderDialog
  def initialize( stack )
    @stack = stack

    # Call @stack.app in order to be able to access global @orders and global @gui_main_window
    @stack.app do
      @gui_main_window.clear{
        border black
        para "Data:", :margin => 4
        date = edit_line "#{Date.today.to_s}", :margin => 4

        para "Client:", :margin => 4
        customer_name = list_box items: @customer_names, :margin => 4

        button "Acceptar", :margin => 4 do
          begin
            customer = CustomerHelper.find_customer_with_name( @customers, customer_name.text)
          rescue Errors::CustomerHelperError
            alert "Selecciona un client"
            return
          end

          # TODO create new dialog for items
        end
      }
    end

  end

end
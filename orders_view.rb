# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'order_view'

class OrdersView < Shoes::Widget

  CONTROLS_COLUMN_WIDTH = '20%'
  ORDER_VIEW_COLUMN_WIDTH = '80%'

  def initialize( orders )
    @orders = orders
    print
  end

  private

  def print
    clear do
      stack :margin => 4 do
        headers
        print_table_body
      end
    end
  end

  def headers
    #flow :margin => 4 do
    #  border black
    #  stack :width => CONTROLS_COLUMN_WIDTH do
    #    para strong(" "), :margin => 4
    #  end
    #  stack :width => ORDER_VIEW_COLUMN_WIDTH do
    #    para strong(" "), :margin => 4
    #  end
    #end
  end

  def print_table_body
    @orders.each do |order|
      flow :margin => 4 do
        border black
        stack :width => CONTROLS_COLUMN_WIDTH do
          flow do
            button "Guardar", :margin => 1 do
              write_order_to_file( order )
              alert "Archiu guardat."
            end
            button "Eliminar", :margin => 1 do
              @orders.delete(order)
              print
            end
          end
        end
        stack :width => ORDER_VIEW_COLUMN_WIDTH do
          order_view order
        end
      end
    end
  end

  def write_order_to_file(order)
    file_path = ask_save_file

    # File object will automatically be closed when the block terminates
    File.open(file_path, 'w') { |file| file.write(order.to_s) }
  end

end
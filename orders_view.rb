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
    flow :margin => 4 do
      border black
      # Empty Stack
      stack :width => CONTROLS_COLUMN_WIDTH

      # Since inheritance does not work well in shoes yet
      # I can not reuse code from OrderView here but this is just a copy from OrdersView.headers function
      # https://github.com/shoes/shoes/issues/164
      stack :width => ORDER_VIEW_COLUMN_WIDTH do
        flow :margin => 4 do
          stack :width => '10%' do
            para strong("DATE"), :margin => 4, :align => 'left'
          end
          stack :width => '10%' do
            para strong("CUSTOMER"), :margin => 4, :align => 'right'
          end
          stack :width => '50%' do
            para strong("PRODUCTES"), :margin => 4, :align => 'center'
          end
          stack :width => '10%' do
            para strong("TOTAL (Sense IVA)"), :margin => 4, :align => 'right'
          end
          stack :width => '10%' do
            para strong("IVA"), :margin => 4, :align => 'right'
          end
          stack :width => '10%' do
            para strong("TOTAL"), :margin => 4, :align => 'right'
          end
        end
      end
    end

  end

  def print_table_body
    @orders.each do |order|
      flow :margin => 4 do
        border black
        stack :width => CONTROLS_COLUMN_WIDTH do
          flow do
            button "Guardar", :margin => 1 do
              write_order_to_file( order )
            end
            button "Eliminar", :margin => 1 do
              @orders.delete(order)
              print
            end
          end
        end
        stack :width => ORDER_VIEW_COLUMN_WIDTH do
          # Include order view with its headers
          order_view :order => order, :headers => false
        end
      end
    end
  end

  def write_order_to_file(order)
    file_path = ask_save_file
    if file_path
      # File object will automatically be closed when the block terminates
      File.open(file_path, 'w') { |file| file.write(order.to_s) }
      alert "Archiu guardat."
    end
  end

end
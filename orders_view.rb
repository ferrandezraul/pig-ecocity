# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class OrdersView < Shoes::Widget

  DATE_COLUMN_WIDTH = '30%'
  CUSTOMER_COLUMN_WIDTH = '15%'
  PRODUCTES_COLUMN_WIDTH = '40%'
  TOTAL_COLUMN_WIDTH = '15%'

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
      stack :width => DATE_COLUMN_WIDTH do
        para strong("DATE"), :margin => 4, :align => 'right'
      end
      stack :width => CUSTOMER_COLUMN_WIDTH do
        para strong("CUSTOMER"), :margin => 4, :align => 'center'
      end
      stack :width => PRODUCTES_COLUMN_WIDTH do
        para strong("PRODUCTES"), :margin => 4, :align => 'right'
      end
      stack :width => TOTAL_COLUMN_WIDTH do
        para strong("TOTAL"), :margin => 4, :align => 'right'
      end
    end
  end

  def print_table_body
    @orders.each do |order|
      flow :margin => 4 do
        border black
        stack :width => DATE_COLUMN_WIDTH do
          flow do
            stack :width => '70%', :align => 'left' do
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
            stack :width => '30%' do
              para "#{order.date}", :margin => 1, :align => 'right'
            end
          end
        end
        stack :width => CUSTOMER_COLUMN_WIDTH do
          para "#{order.customer.name}", :margin => 4, :align => 'center'
        end
        stack :width => PRODUCTES_COLUMN_WIDTH do
          order.order_items.each do |order_item|
            para order_item.to_s, :margin => 4, :align => 'right'
          end
        end
        stack :width => TOTAL_COLUMN_WIDTH do
          para "#{ '%.2f' % order.total} €", :margin => 4, :align => 'right'
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
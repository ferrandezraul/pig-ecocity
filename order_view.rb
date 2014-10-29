# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class OrderView < Shoes::Widget

  DATE_COLUMN_WIDTH = '15%'
  CUSTOMER_COLUMN_WIDTH = '15%'
  PRODUCTES_COLUMN_WIDTH = '50%'
  TOTAL_COLUMN_WIDTH = '20%'

  def initialize( order )
    @order = order

    print
  end

  private

  def headers
    flow :margin => 4 do
      border black
      stack :width => DATE_COLUMN_WIDTH do
        para strong("DATE"), :margin => 4, :align => 'left'
      end
      stack :width => CUSTOMER_COLUMN_WIDTH do
        para strong("CUSTOMER"), :margin => 4, :align => 'right'
      end
      stack :width => PRODUCTES_COLUMN_WIDTH do
        para strong("PRODUCTES"), :margin => 4, :align => 'center'
      end
      stack :width => TOTAL_COLUMN_WIDTH do
        para strong("TOTAL"), :margin => 4, :align => 'right'
      end
    end
  end

  def table_body
    flow :margin => 4 do
      border black
      stack :width => DATE_COLUMN_WIDTH do
        para "#{@order.date}", :margin => 4, :align => 'left'
      end
      stack :width => CUSTOMER_COLUMN_WIDTH do
        para "#{@order.customer.name}", :margin => 4, :align => 'right'
      end
      stack :width => PRODUCTES_COLUMN_WIDTH do
        @order.order_items.each do |order_item|
          flow :margin => 4 do
            stack :width => '20%' do
              button "Eliminar", :margin => 4 do
                @order.delete(order_item)
                print
              end
            end
            stack :width => '80%' do
              para order_item.item_to_s, :margin => 4, :align => 'right'
              para order_item.subproducts_to_s, :emphasis => 'italic', :margin => 4, :align => 'right' if order_item.sub_products.any?
            end
          end
        end
      end
      stack :width => TOTAL_COLUMN_WIDTH do
        para "#{ '%.2f' % @order.total} €", :margin => 4, :align => 'right'
      end
    end
  end

  def print
    clear do
      stack :margin => 4 do
        headers
        table_body
      end
    end
  end

end
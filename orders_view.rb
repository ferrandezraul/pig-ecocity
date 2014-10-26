$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class OrdersView < Shoes::Widget
  def initialize( orders )
    stack :margin => 4 do
      headers
      orders.each do |order|
        flow :margin => 4 do
          stack :width => '25%' do
            para "#{order.date}", :margin => 4, :align => 'left'
          end
          stack :width => '25%' do
            para "#{order.customer.name}", :margin => 4, :align => 'right'
          end
          stack :width => '25%' do
            para "#{ order.order_items}", :margin => 4, :align => 'right'
          end
          stack :width => '25%' do
            para "#{ '%.2f' % order.total} €", :margin => 4, :align => 'right'
          end
        end
      end
    end
  end

  def headers
    flow :margin => 4 do
      stack :width => '25%' do
        para strong("DATE"), :margin => 4, :align => 'left'
      end
      stack :width => '25%' do
        para strong("CUSTOMER"), :margin => 4, :align => 'right'
      end
      stack :width => '25%' do
        para strong("PRODUCTES"), :margin => 4, :align => 'right'
      end
      stack :width => '25%' do
        para strong("TOTAL"), :margin => 4, :align => 'right'
      end
    end
  end
end
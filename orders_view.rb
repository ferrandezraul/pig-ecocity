$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class OrdersView < Shoes::Widget
  def initialize( orders )
    stack do
      orders.each do |order|
        para "#{order.to_s}"
      end
    end
  end
end
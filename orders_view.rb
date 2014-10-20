$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class OrdersView
  def initialize( app, orders)
    @app = app
    @orders = orders

    @gui = @app.flow do
      print_orders(@orders)
    end
  end


  private

  def print_orders(orders)
    @app.flow do
      orders.each do |order|
        @app.stack :margin => 4, :width => -110 do
          @app.para "#{order.to_s}\n", :stroke => "#CD9", :margin => 4
        end
        @app.stack :margin => 4, :width => 110 do
          @app.button "Eliminar", :margin => 4 do
            delete(order)
          end
        end
      end
    end
  end

  def delete(order)
    @orders.delete(order)
    debug("Deleted order from #{order.customer.name}.")
    @gui.clear { print_orders(@orders) }
  end


end
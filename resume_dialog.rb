$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_helper'
require 'customer_helper'

class ResumeDialog
  def initialize( app, orders, pig, products)
    @app = app
    @orders = orders
    @pig = pig
    @product_names = ProductHelper.names(products)

    @app.flow :margin => 4 do

      # stack 230 pixels wide
      @app.stack :margin => 4, :width => 240 do
        @app.border "#CD9"
        @app.para "Porc restant", :stroke => "#CD9", :margin => 4
        @app.para @pig.to_s, :stroke => "#CD9", :margin => 4
      end

      # stack 100% minus 230 pixels wide
      @app.stack :margin => 4, :width => -240 do
        @app.border "#CD9"
        @app.para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
        @app.list_box items: @product_names, :margin => 4 do |product_name|
          times_ordered = 0
          kg_ordered = 0
          euros_ordered = 0
          @orders.each do |order|
            times_ordered += order.times_ordered(product_name.text)
            kg_ordered += order.kg_ordered(product_name.text)
            euros_ordered += order.euros_ordered(product_name.text)
          end
          @gui_text_resume.clear {
            @app.para "Ordered #{times_ordered.to_i} times\n", :stroke => "#CD9", :margin => 4
            @app.para @app.strong("Total #{'%.3f' % kg_ordered.to_f} Kg\n"), :stroke => "#CD9", :margin => 4
            @app.para @app.strong("Total #{'%.2f' % euros_ordered.to_f} EUR\n"), :stroke => "#CD9", :margin => 4
          }
        end
        @gui_text_resume = @app.flow
      end

    end
  end

end
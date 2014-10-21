$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class NewOrderView

  def initialize( app, products, customer, date )
    @app = app
    @products = products.dup
    @product_names = ProductHelper.names(@products)

    @order = Order.new( customer, [], date )
    draw
  end

  private

  def draw
    @app.flow :margin => 4 do
      @app.border "#CD9"

      # This stack is 260 pixels wide. See http://shoesrb.com/manual/Rules.html
      @app.stack :margin => 4, :width => 260 do
        @app.para "Producte:", :stroke => "#CD9", :margin => 4
        @app.list_box items: @product_names, :margin => 2 do |list|
          @selected_product = ProductHelper.find_product_with_name( @products, list.text )
        end

        @gui_subproducts = @app.stack :margin => 4

        @app.para "Observacions:", :stroke => "#CD9", :margin => 4
        @observations = @app.edit_line :margin => 4
        @app.para "Quantitat:", :stroke => "#CD9", :margin => 4
        @quantity = @app.edit_line :margin => 4
        @app.para "Pes en Kg: (ex. 0.2 = 200g.)", :stroke => "#CD9", :margin => 4
        @app.flow do
          @gui_weigh = @app.edit_line :margin => 2
          @app.para "Kg", :stroke => "#CD9", :margin => 2
        end

        @app.button "Afegir Producte", :margin => 10 do
        end
      end

      # @gui_order_view is a stack 100% minus 260 pixels wide
      @gui_order_view = @app.stack :margin => 4, :width => -260 do
        @app.para "#{@order.customer.to_s}", :stroke => "#CD9", :margin => 4
      end
    end

    @app.stack :margin => 4, :width => 260 do
      @app.button "Crear comanda", :margin => 10 do
      end
    end
  end


end
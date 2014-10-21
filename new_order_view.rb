$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'order_item'

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
      @app.border @app.black

      # This stack is 260 pixels wide. See http://shoesrb.com/manual/Rules.html
      @app.stack :margin => 4, :width => 260 do
        @app.para "Producte:", :margin => 4
        @app.list_box items: @product_names, :margin => 2 do |list|
          @selected_product = ProductHelper.find_product_with_name( @products, list.text )
        end

        @gui_subproducts = @app.stack :margin => 4

        @app.para "Observacions:", :margin => 4
        @observations = @app.edit_line :margin => 4
        @app.para "Quantitat:", :margin => 4
        @quantity = @app.edit_line :margin => 4
        @app.para "Pes en Kg: (ex. 0.2 = 200g.)", :margin => 4
        @app.flow do
          @weight = @app.edit_line :margin => 2
          @app.para "Kg", :margin => 2
        end

        @app.button "Afegir Producte", :margin => 10 do
          if valid_parameters?
            @order << OrderItem.new( @order.customer, @selected_product, @quantity.text.to_i, @weight.text.to_f, @observations.text, [] )
            @gui_order_view.clear{
              order_header_text
              order_items_text
            }
          end
        end
      end

      # @gui_order_view is a stack 100% minus 260 pixels wide
      @gui_order_view = order_header_text
    end

    @app.stack :margin => 4, :width => 260 do
      @app.button "Crear comanda", :margin => 10 do
      end
    end

  end

  def order_header_text
    @app.stack :margin => 4, :width => -260 do
      @app.para "#{@order.date.to_s}", :margin => 4
      @app.para "#{@order.customer.name}", :margin => 4
      @app.para "#{@order.customer.address}", :margin => 4
    end
  end

  def order_items_text
    total = 0
    @order.order_items.each do |item|
      total += item.price
      @app.flow do
        @app.stack :width => -110, :margin => 4 do
          @app.para "#{item.to_s}", :margin => 4, :align => 'right'
        end
        @app.stack :width => 110 do
          @app.button "Eliminar", :margin => 4 do
            #TODO
          end
        end
      end

    end
    @app.para @app.strong( "TOTAL = #{'%.2f' % total} EUR"), :margin => 8, :align => 'right'
  end

  def valid_parameters?
    if @order.nil?
      alert "invalid order"
      return false
    elsif @order.customer.nil?
      alert "invalid customer"
      return false
    elsif @quantity.text.empty?
      alert "Quantitat ha de ser un numero"
      return false
    elsif @weight.text.empty?
      alert "Pes ha de ser un numero en kg"
      return false
    elsif @observations.nil?
      @observations.text = ""
    end

    return true

  end

end
$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_helper'
require 'customer_helper'
require 'subproducts_dialog'

class OrderItemsDialog
  attr_reader :ordered_items

  def initialize( app, products, order_view )
    @app = app
    @products = products
    @product_names = ProductHelper.names(products)
    @ordered_items = []
    @gui_order_view = order_view

    @gui_subproducts_dialog = SubProductsDialog.new( @app )
  end

  # deletes ordered_items
  def customer=(customer)
    @ordered_items.clear
    @customer = customer
  end

  def clear
    @ordered_items.clear
    @gui_observations.text = ""
    @gui_subproducts_dialog.clear
  end

  def draw
    @app.para "Producte:", :stroke => "#CD9", :margin => 4
    @gui_product_name_selected = @app.list_box items: @product_names, :margin => 2 do |list|
      product = ProductHelper.find_product_with_name( @products, list.text )
      if product.has_subproducts?
        subproducts = product.subproducts
        @gui_subproducts.clear{
          @gui_subproducts_dialog.subproducts = subproducts
        }
      else
        @gui_subproducts.clear
      end
    end

    # @gui_text_order_items is a stack 100% minus 230 pixels wide
    @gui_subproducts = @app.stack :margin => 4

    @app.para "Observacions:", :stroke => "#CD9", :margin => 4
    @gui_observations = @app.edit_line items: @customer_names, :margin => 4
    @app.para "Quantitat:", :stroke => "#CD9", :margin => 4
    @quantity = @app.edit_line :margin => 4
    @app.para "Pes en Kg: (ex. 0.2 = 200g.)", :stroke => "#CD9", :margin => 4
    @app.flow do
      @gui_weigh = @app.edit_line :margin => 2
      @app.para "Kg", :stroke => "#CD9", :margin => 2
    end

    @app.button "Afegir Producte", :margin => 10 do
      # Also uses internally @gui_subproducts_dialog
      add_item_to_ordered_items( @gui_product_name_selected.text, @quantity.text, @gui_weigh.text, @gui_observations.text )
      @gui_order_view.clear { print_items( @ordered_items ) }
      @gui_subproducts_dialog.clear
    end
  end

  private


  def add_item_to_ordered_items( product_name, quantity, weigh, observations )
    if Order.attributes_valid?( @customer.name, product_name, quantity, weigh )
      product = ProductHelper.find_product_with_name( @products, product_name )

      # TODO
      subproducts = @gui_subproducts_dialog.get_selected_subproducts
      @ordered_items << OrderItem.new( @customer, product, quantity.to_i, weigh.to_f, observations, subproducts )
      debug( "Product #{product_name} added to order from #{@customer.name}." )
      debug(OrderItem.new( @customer, product, quantity.to_i, weigh.to_f, observations, subproducts ))
    end
  end

  def print_items(items)
    total = 0
    items.each do |item|
      total += item.price
      @app.flow do
        @app.stack :width => -110, :margin => 4 do
          @app.para "#{item.to_s}", :stroke => "#CD9", :margin => 4, :align => 'right'
        end
        @app.stack :width => 110 do
          @app.button "Eliminar", :margin => 4 do
            delete(item)
            debug("Deleted #{item.product.name} from order.")
          end
        end
      end

    end
    @app.para @app.strong( "TOTAL = #{'%.2f' % total} EUR"), :stroke => "#CD9", :margin => 8, :align => 'right'
  end

  def delete(item)
    @ordered_items.delete(item)
    debug("Deleted #{item.product.name} from order.")
    @gui_order_view.clear { print_items( @ordered_items ) }
  end

end
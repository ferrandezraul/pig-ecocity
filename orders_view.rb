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
            para print_order_item_entry(order_item), :margin => 4, :align => 'right'
            para print_subproducts(order_item.sub_products), :emphasis => 'italic', :margin => 4, :align => 'right' if order_item.sub_products.any?
          end
        end
        stack :width => TOTAL_COLUMN_WIDTH do
          para "#{ '%.2f' % order.total} €", :margin => 4, :align => 'right'
        end
      end
    end
  end

  def print_order_item_entry(order_item)
    order_item_string = String.new
    if order_item.weight.to_f == 0.0
      order_item_string << "#{order_item.quantity.to_i} x #{order_item.product.name} = #{'%.2f' % order_item.price.to_f} €"
    else
      order_item_string << "#{order_item.quantity.to_i} x #{'%.3f' % order_item.weight.to_f} kg #{order_item.product.name} = #{'%.2f' % order_item.price.to_f} €"
    end

    order_item_string
  end

  def print_subproducts(sub_products)
    sub_string = String.new
    if sub_products.any?
      sub_products.each do |subproduct|
        sub_string += "#{subproduct.quantity} x #{subproduct.weight} kg #{subproduct.name}\n"
      end
    end

    sub_string
  end

  def write_order_to_file(order)
    file_path = ask_save_file

    # File object will automatically be closed when the block terminates
    File.open(file_path, 'w') { |file| file.write(order.to_s) }
  end

end
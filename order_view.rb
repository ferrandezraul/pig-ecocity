# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class OrderView < Shoes::Widget
  def initialize( order )
    @order = order

    print
  end

  private

  def headers
    flow :margin => 4 do
      border black
      stack :width => '15%' do
        para strong("DATE"), :margin => 4, :align => 'left'
      end
      stack :width => '15%' do
        para strong("CUSTOMER"), :margin => 4, :align => 'right'
      end
      stack :width => '50%' do
        para strong("PRODUCTES"), :margin => 4, :align => 'center'
      end
      stack :width => '20%' do
        para strong("TOTAL"), :margin => 4, :align => 'right'
      end
    end
  end

  def table_body
    flow :margin => 4 do
      border black
      stack :width => '15%' do
        para "#{@order.date}", :margin => 4, :align => 'left'
      end
      stack :width => '15%' do
        para "#{@order.customer.name}", :margin => 4, :align => 'right'
      end
      stack :width => '50%' do
        @order.order_items.each do |order_item|
          flow :margin => 4 do
            stack :width => '20%' do
              button "Eliminar", :margin => 4 do
                @order.delete(order_item)
                print
              end
            end
            stack :width => '80%' do
              para print_order_item_entry(order_item), :margin => 4, :align => 'right'
            end
          end
          para print_subproducts(order_item.sub_products), :emphasis => 'italic', :margin => 4, :align => 'right' if order_item.sub_products.any?
        end
      end
      stack :width => '20%' do
        para "#{ '%.2f' % @order.total} €", :margin => 4, :align => 'right'
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

  def print
    clear do
      stack :margin => 4 do
        headers
        table_body
      end
    end
  end

end
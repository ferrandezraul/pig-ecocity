# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class OrdersView < Shoes::Widget
  def initialize( orders )
    stack :margin => 4 do
      headers
      orders.each do |order|
        flow :margin => 4 do
          border black
          stack :width => '10%' do
            para "#{order.date}", :margin => 4, :align => 'left'
          end
          stack :width => '25%' do
            para "#{order.customer.name}", :margin => 4, :align => 'right'
          end
          stack :width => '40%' do
            order.order_items.each do |order_item|
              para print_order_item_entry(order_item), :margin => 4, :align => 'right'
              para print_subproducts(order_item.sub_products), :emphasis => 'italic', :margin => 4, :align => 'right' if order_item.sub_products.any?
            end
          end
          stack :width => '25%' do
            para "#{ '%.2f' % order.total} €", :margin => 4, :align => 'right'
          end
        end
      end
    end
  end

  private

  def headers
    flow :margin => 4 do
      border black
      stack :width => '10%' do
        para strong("DATE"), :margin => 4, :align => 'left'
      end
      stack :width => '25%' do
        para strong("CUSTOMER"), :margin => 4, :align => 'right'
      end
      stack :width => '40%' do
        para strong("PRODUCTES"), :margin => 4, :align => 'right'
      end
      stack :width => '25%' do
        para strong("TOTAL"), :margin => 4, :align => 'right'
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

end
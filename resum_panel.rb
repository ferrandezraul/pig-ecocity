# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ResumPanel < Shoes::Widget
  def initialize( products, customers, orders )
    @product_names = ProductHelper.names(products)
    @orders = orders
    @customers = customers
    print
  end

  private

  def print
    clear do
      stack :margin => 4 do
        para "Selecciona el producte:", :margin => 4
        list_box items: @product_names, :margin => 4 do |product_name|
          times_ordered = 0
          kg_ordered = 0
          euros_ordered = 0
          @orders.each do |order|
            times_ordered += order.times_ordered(product_name.text)
            kg_ordered += order.kg_ordered(product_name.text)
            euros_ordered += order.euros_ordered(product_name.text)
          end
          @gui_text_resume.clear { print_resume(times_ordered, kg_ordered, euros_ordered)}
        end
      end

      @gui_text_resume = stack :margin => 4
    end
  end

  def print_resume( times_ordered, kg_ordered, euros_ordered)
    para "Ordered #{times_ordered.to_i} times\n", :margin => 4
    para strong("Total #{'%.3f' % kg_ordered.to_f} Kg\n"), :margin => 4
    para strong("Total #{'%.2f' % euros_ordered.to_f} EUR\n"), :margin => 4
  end

end
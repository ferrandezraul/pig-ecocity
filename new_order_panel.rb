$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'products_view'
require 'product_helper'
require 'customer_helper'

class NewOrderPanel < Shoes::Widget

  def initialize( products, customers )
    @products = products
    @customers = customers
    @product_names = ProductHelper.names(@products)
    @customer_names = CustomerHelper.names(@customers)

    select_date_and_customer

    # Use yield here to implement something from the caller??
  end

  private

  def select_date_and_customer
    stack do
      # Enter date and customer
      para "Data:", :margin => 4
      @date = "#{Date.today.to_s}"
      edit_line "#{Date.today.to_s}", :margin => 4 do |line|
        @date = line.text
      end

      para "Client:", :margin => 4
      list_box items: @customer_names, :margin => 4 do |list|
        @selected_customer = CustomerHelper.find_customer_with_name( @customers, list.text)
      end

      button "Acceptar" do
        if @selected_customer
          select_product
        end
      end
    end
  end

  def select_product
    clear do
      stack do
        para "Producte:", :margin => 4
        list_box items: @product_names, :margin => 4 do |list|
          @selected_product = ProductHelper.find_product_with_name( @products, list.text )
        end

        @observations = ""
        para "Observacions:", :margin => 4
        edit_line :margin => 4 do |line|
          @observations = line.text
        end

        @quantity = 0
        para "Quantitat:", :margin => 4
        edit_line :margin => 4 do |quantity|
          @quantity = quantity.text.to_i
        end

        @weight = 0
        para "Pes en Kg: (ex. 0.2 = 200g.)", :margin => 4
        flow do
          edit_line :margin => 2 do |weight|
            @weight = weight.text.to_f
          end
          para "Kg", :margin => 2
        end

        button "Afegir Producte", :margin => 10 do
          if valid_parameters?
            # Create order item
          end
        end
      end
    end
  end

  def valid_parameters?
    if @selected_product.nil?
      alert "Selecciona un producte"
      return false
    elsif @quantity == 0
      alert "Quantitat ha de ser un numero"
      return false
    elsif @weight == 0
      alert "Pes ha de ser un numero en kg"
      return false
    end

    return true

  end

end
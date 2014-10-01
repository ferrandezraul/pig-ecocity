# See shoes examples expert-funnies.rb

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_csv'
require 'customers_csv'
require 'order'


Shoes.app :width => 800, :height => 600 do
  background "#555"

  @title = "Ecocity Porc"

  def products_csv__path
    return ::File.join( File.dirname( __FILE__ ), "csv/products.csv" )
  end

  def customers_csv__path
    return ::File.join( File.dirname( __FILE__ ), "csv/customers.csv" )
  end

  def load_products
    begin
      @products = ProductCSV.read( products_csv__path )
    rescue Errors::ProductCSVError => e
      alert e.message
    end

    @product_names = []
    @products.each do |product|
      @product_names << product.name
    end
  end

  def load_customers
    begin
      @customers = CustomerCSV.read( customers_csv__path )
    rescue Errors::CustomersCSVError => e
      alert e.message
    end

    @customer_names = []
    @customers.each do |customer|
      @customer_names << customer.name
    end
  end

  def product_with_name(name)
    @products.each do |product|
      if product.name == name
        return product
      end
    end
    alert "Product with name \"#{name}\" not found"
  end

  def customer_with_name(name)
    @customers.each do |customer|
      if customer.name == name
        return customer
      end
    end
    alert "Customer with name \"#{name}\" not found"
  end

  def get_new_order
    stack :margin => 4 do
      para "Selecciona el client:", :stroke => "#CD9", :margin => 4
      customer_name = list_box items: @customer_names
      para "Selecciona el producte:", :stroke => "#CD9", :margin => 4
      product_name = list_box items: @product_names
      para "Selecciona quantitat:", :stroke => "#CD9", :margin => 4
      quantity = edit_line
      para "Selecciona el pes en grams:", :stroke => "#CD9", :margin => 4
      peso = edit_line

      button "Crear comanda", :margin => 10 do
        if quantity.text.to_i <= 0
          alert "Quantitat ha de ser mes gran que 0"
          return
        end

        product = product_with_name(product_name.text)
        customer = customer_with_name(customer_name.text)

        if product.nil? or customer.nil?
          return
        end

        @orders << ::Order.new( customer, product, quantity.text.to_i, peso.text.to_i )

        alert "Comanda afegida!"
      end
    end
  end

  stack :margin => 10 do
    title strong(@title), :align => "center", :stroke => "#DFA", :margin => 0

    load_products
    load_customers

    @orders = []

    flow :margin => 10 do
      button "Productes", :margin => 4 do
        @p.clear{
          @products.each do |product|
            para "#{product.to_s}\n", :stroke => "#CD9", :margin => 4
          end
        }
      end

      button "Comandes", :margin => 4 do
        @p.clear{
          @orders.each do |order|
            para "Comanda per #{order.customer.name}\n", :stroke => "#CD9", :margin => 4
            para "#{order.quantity.to_i} x #{order.weight.to_i} g. #{order.product.name}", :stroke => "#CD9", :margin => 4
          end
        }
      end

      button "Clients", :margin => 4 do
        @p.clear{
          @customers.each do |customer|
            para "#{customer.to_s}\n", :stroke => "#CD9", :margin => 4
          end
        }
      end

      button "Nova Comanda", :margin => 4 do
        @p.clear{
          get_new_order
        }
      end

      # This is for clearing flow when user press any button
      # extracted from here http://ruby.about.com/od/shoes/ss/shoes3_2.htm
      @p = flow

    end

  end
end
$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'products_view'
require 'orders_view'
require 'customers_view'
require 'new_order_panel'

class MenuPanel < Shoes::Widget

  def initialize( args )
    style(Link, :underline => nil)
    @products = args[:products]
    @customers = args[:customers]
    @orders = args[:orders]

    print_links
  end

  private

  def view_products
    clear do
      print_links
      products_view @products
    end
  end

  def view_customers
    clear do
      print_links
      customers_view @customers
    end
  end

  def view_orders
    clear do
      print_links
      orders_view @orders
    end
  end

  def new_order
    clear do
      print_links
      new_order_panel @products, @customers, @orders
    end
  end

  def print_links
    flow do
      para link("Productes").click { view_products }, :margin => 10
      para link("Clients").click { view_customers }, :margin => 10
      para link("Comandes").click { view_orders }, :margin => 10
      para link("Nova Comanda").click { new_order }, :margin => 10
    end
  end

end
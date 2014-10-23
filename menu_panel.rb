$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'products_view'

class MenuPanel < Shoes::Widget

  def initialize( args )
    @products = args[:products]
    print_links

    # Use yield here to implement something from the caller??
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
      para "Estos son mis clientes"
    end
  end

  def view_orders
    clear do
      print_links
      para "Estas son mis comandas"
    end
  end

  def new_order
    clear do
      print_links
      para "Lets create an order!!"
    end
  end

  def print_links
    para link("Productes").click { view_products }, :margin => 4
    para link("Clients").click { view_customers }, :margin => 4
    para link("Comandes").click { view_orders }, :margin => 4
    para link("Nova Comanda").click { new_order }, :margin => 4
  end

end
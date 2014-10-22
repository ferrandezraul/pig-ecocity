class MenuPanel < Shoes::Widget

  def initialize( args )
    para link("Productes").click { visit "/view_products" }, :margin => 4
    para link("Clients").click { visit "/view_customers" }, :margin => 4
    para link("Comandes").click { visit "/view_orders" }, :margin => 4
    para link("Nova Comanda").click { visit "/new_order" }, :margin => 4

    # Use yield here to implement something from the caller??
  end

  def view_products
    debug("Sii")
    para "Estos son mis productos"
  end

  def view_customers
    para "Estos son mis clientes"
  end

  def view_orders
    para "Estas son mis comandas"
  end

  def new_order
    para "Lets create an order!!"
  end

end

Shoes.app :width => 600, :height => 130 do
  menu_panel :width => 500, :height => 500, :margin => 4
end

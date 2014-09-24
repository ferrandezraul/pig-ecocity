class Main < Shoes
  # Url method comes from Shoes
  url '/', :index        # draws page from the index method   (you can organise your methods in different classes)
  url '/products', :products   # draws page from the products method
  url '/orders', :orders   # draws page from the orders method
  url '/summary', :summary # draws page from the summary method
  url '/new_order', :new_order # draws page from the new_order method

  def index
    para link("Products\n", :click => "/products"),
         link("Orders\n", :click => "/orders"),
         link("Summary\n", :click => "/summary")
         link("New Order\n", :click => "/new_order")
  end

  def products
    para "Products:\n",
         link("Go back.", :click => "/")
  end

  def orders
    para "Orders in place:\n "

    para link("New Order\n", :click => "/new_order")

    para link("Go back.\n", :click => "/")
  end

  def summary
    para "Summary:\n ",
         link("Go back.\n", :click => "/")
  end

  def new_order
    para "New Order:\n"

    para link("Go back.\n", :click => "/")
  end

end

# Need this. That's what opens the window
Shoes.app :title => "Porc Ecocity", :width => 400, :height => 500
# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'products_view'
require 'orders_view'
require 'customers_view'
require 'new_order_panel'
require 'resum_panel'
require 'json'

$LOAD_PATH << ENV['HOME']+ '/.rvm/gems/ruby-2.0.0-p247@pigecocity/gems/awesome_print-1.2.0/lib'
require 'awesome_print'

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
    products_view @products
  end

  def view_customers
    customers_view @customers
  end

  def view_orders
    orders_view @orders
  end

  def new_order
    new_order_panel @products, @customers, @orders
  end

  def resum
    resum_panel @products, @customers, @orders
  end

  def save_orders
    if @orders.any?
      para JSON.pretty_generate(@orders)
      write_orders_to_json_file
    end
  end

  def write_orders_to_json_file
    file_path = ask_save_file
    if file_path
      # File object will automatically be closed when the block terminates
      File.open(file_path, 'w') { |file| file.write(JSON.pretty_generate(@orders)) }
      alert "Archiu guardat."
    end
  end

  def print_links
    flow do
      para link( 'Productes' ).click {
        clear do
          print_links
          view_products
        end
      }, :margin => 10
      para link( 'Clients' ).click {
        clear do
          print_links
          view_customers
        end
      }, :margin => 10
      para link( 'Comandes' ).click {
        clear do
          print_links
          view_orders
        end
      }, :margin => 10
      para link( 'Nova Comanda' ).click {
        clear do
          print_links
          new_order
        end
      }, :margin => 10
      para link( 'Resum' ).click {
        clear do
          print_links
          resum
        end
      }, :margin => 10
      para link( 'Save Orders' ).click {
        save_orders
      }, :margin => 10
    end
  end

end
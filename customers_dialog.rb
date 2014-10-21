$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class CustomersDialog
  attr_reader :customer_name

  # Dialog for user to select a customer
  # Returns a string with selected customer name:
  # == Example
  #
  # dialog = CustomersDialog.new( Shoes.app, customer_names )
  # ...
  # customer_name = dialog.customer_name
  #
  def initialize( app, customer_names )
    @app = app
    @customer_names = customer_names
    @customer_name = ""

    draw
  end

  private

  def draw
    @app.border @app.black

    @app.para "Client:", :margin => 4
    @app.list_box items: @customer_names, :margin => 4 do |name|
      @customer_name = name.text
    end
  end

end
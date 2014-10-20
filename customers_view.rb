$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class CustomersView
  def initialize( app, customers)
    @app = app
    @customers = customers

    @gui = @app.flow do
      print_customers(@customers)
    end
  end


  private

  def print_customers(customers)

    customers.each do |customer|
      @app.para "#{customer.to_s}\n", :stroke => "#CD9", :margin => 4

      #@app.stack :margin => 4, :width => 110 do
      #  @app.button "Eliminar", :margin => 4 do
      #    delete(customer)
      #  end
      #end
    end
  end


  #def delete(customer)
  #  @customers.delete(customer)
  #  debug("Deleted customer #{customer.name}.")
  #  @gui.clear { print_customers(@customers) }
  #end

end
$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'customer_helper'

class DateCustomerDialog < Shoes::Widget

  def initialize( args )
    customers = args[:items]
    customer_names = CustomerHelper.names(customers)
    selected_customer = nil
    date = "#{Date.today.to_s}"

    stack :margin => 4 do
      border black
      para "Data:", :margin => 4
      edit_line date, :margin => 4 do |line|
        date = line.text
      end

      para "Client:", :margin => 4
      list_box items: customer_names, :margin => 4 do |list|
        selected_customer = CustomerHelper.find_customer_with_name( customers, list.text )
      end

      button "Acceptar", :margin => 4 do
        alert "Selecciona un client." unless selected_customer
        alert "Selecciona una data" if date.empty?
        yield [selected_customer,date]
      end
    end
  end

end
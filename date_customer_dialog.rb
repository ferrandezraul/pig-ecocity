$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'customer_helper'

class DateCustomerDialog < Shoes::Widget

  def initialize( args )
    @customers = args[:items]

    @customer_names = CustomerHelper.names(@customers)

    @selected_customer_name = nil

    stack :margin => 4 do
      border black
      para "Data:", :margin => 4
      @date = "#{Date.today.to_s}"
      edit_line "#{Date.today.to_s}", :margin => 4 do |line|
        @date = line.text
      end

      para "Client:", :margin => 4
      list_box items: @customer_names, :margin => 4 do |list|
        @selected_customer_name = list.text

        if @selected_customer_name.nil? || @selected_customer_name.empty?
          debug("Selected customer is nil")
        else
          debug("Selected customer is NOT nil")
        end
      end

      button "Acceptar", :margin => 4 do
        alert "Selecciona un client." unless @selected_customer_name

        yield @date
        yield @selected_customer_name
      end
    end
  end

end
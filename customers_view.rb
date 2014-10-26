$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class CustomersView < Shoes::Widget
  def initialize( customers )
    stack do
      customers.each do |customer|
        para "#{customer.to_s}"
      end
    end
  end
end
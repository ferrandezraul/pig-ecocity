$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class CustomersView < Shoes::Widget
  def initialize( customers )
    stack :margin => 4 do
      headers
      customers.each do |customer|
        flow :margin => 4 do
          stack :width => '33%' do
            para "#{customer.name}", :margin => 4, :align => 'left'
          end
          stack :width => '33%' do
            para "#{customer.address} €/KG", :margin => 4, :align => 'right'
          end
          stack :width => '33%' do
            #para "#{customer.nif} €/KG", :margin => 4, :align => 'right'
            para "77314883-S", :margin => 4, :align => 'right'
          end
        end
      end
    end
  end

  def headers
    flow :margin => 4 do
      stack :width => '33%' do
        para strong("NAME"), :margin => 4, :align => 'left'
      end
      stack :width => '33%' do
        para strong("ADDRESS"), :margin => 4, :align => 'right'
      end
      stack :width => '33%' do
        para strong("NIF"), :margin => 4, :align => 'right'
      end
    end
  end

end
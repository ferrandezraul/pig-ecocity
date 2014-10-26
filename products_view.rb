# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ProductsView < Shoes::Widget
  def initialize( products )
    stack :margin => 4 do
      headers
      products.each do |product|
        flow :margin => 4 do
          stack :width => '25%' do
            para "#{product.name}", :margin => 4, :align => 'left'
          end
          stack :width => '25%' do
            para "#{ '%.2f' % product.price_tienda} €/KG", :margin => 4, :align => 'right'
          end
          stack :width => '25%' do
            para "#{ '%.2f' % product.price_coope} €/KG", :margin => 4, :align => 'right'
          end
          stack :width => '25%' do
            para "#{ '%.2f' % product.price_pvp} €/KG", :margin => 4, :align => 'right'
          end
        end
      end
    end
  end

  private

  def headers
    flow :margin => 4 do
      stack :width => '25%' do
        para strong("NAME"), :margin => 4, :align => 'left'
      end
      stack :width => '25%' do
        para strong("TIENDA"), :margin => 4, :align => 'right'
      end
      stack :width => '25%' do
        para strong("COOPE"), :margin => 4, :align => 'right'
      end
      stack :width => '25%' do
        para strong("PVP"), :margin => 4, :align => 'right'
      end
    end
  end

end
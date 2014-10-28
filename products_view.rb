# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ProductsView < Shoes::Widget

  COLUMN_NAME_WIDTH = '25%'
  COLUMN_PRICE_1_WIDTH = '25%'
  COLUMN_PRICE_2_WIDTH = '25%'
  COLUMN_PRICE_3_WIDTH = '25%'

  def initialize( products )
    stack :margin => 4 do
      headers
      products.each do |product|
        flow :margin => 4 do
          stack :width => COLUMN_NAME_WIDTH do
            para "#{product.name}", :margin => 4, :align => 'left'
          end
          stack :width => COLUMN_PRICE_1_WIDTH do
            para "#{ '%.2f' % product.price_tienda} €/KG", :margin => 4, :align => 'right'
          end
          stack :width => COLUMN_PRICE_2_WIDTH do
            para "#{ '%.2f' % product.price_coope} €/KG", :margin => 4, :align => 'right'
          end
          stack :width => COLUMN_PRICE_3_WIDTH do
            para "#{ '%.2f' % product.price_pvp} €/KG", :margin => 4, :align => 'right'
          end
        end
      end
    end
  end

  private

  def headers
    flow :margin => 4 do
      border black
      stack :width => COLUMN_NAME_WIDTH do
        para strong("NAME"), :margin => 4, :align => 'left'
      end
      stack :width => COLUMN_PRICE_1_WIDTH do
        para strong("TIENDA"), :margin => 4, :align => 'right'
      end
      stack :width => COLUMN_PRICE_2_WIDTH do
        para strong("COOPE"), :margin => 4, :align => 'right'
      end
      stack :width => COLUMN_PRICE_3_WIDTH do
        para strong("PVP"), :margin => 4, :align => 'right'
      end
    end
  end

end
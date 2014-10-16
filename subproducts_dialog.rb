$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_helper'
require 'customer_helper'

class SubProductsDialog
  def initialize( app, subproducts)
    @app = app
    @subproducts = subproducts
    draw

  end

  private

  def draw
    @app.para "Tria els productes del lot:", :stroke => "#CD9", :margin => 4
    subproducts_weight = []
    subproducts_name = []
    @subproducts.each do |subproduct|
      @app.flow do
        @app.stack :margin => 2, :width => 50 do
          @app.edit_line "#{subproduct[:weight]}", :stroke => "#CD9", :width => 50
        end
        @app.stack :margin => 2, :width => -50 do
          print_product_name( subproduct[:product].name )
        end
      end
    end
  end

  def print_product_name(name)
    # http://stackoverflow.com/questions/14714936/fix-ruby-string-to-n-characters
    @app.para "kg #{'%-25.25s' % name}", :stroke => "#CD9", :width => -50
  end

end
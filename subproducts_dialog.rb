$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_helper'
require 'customer_helper'

class SubProductsDialog
  attr_reader :subproducts_selected

  def initialize( app, subproducts)
    @app = app
    @subproducts = subproducts
    @subproducts_selected = []
    draw
  end

  private

  def draw
    @app.para "Tria els productes del lot:", :stroke => "#CD9", :margin => 4

    @gui_selected = @subproducts.map do |subproduct|
      @app.flow do
        @checked = @app.check :margin => 4
        # Default weight comes from subproduct
        @weight = @app.edit_line "#{subproduct.weight}", :stroke => "#CD9", :width => 50
        print_product_name( subproduct.name )
        @name = subproduct.name
      [ @checked, @weight, @name]
      end
    end

  end

  def print_product_name(name)
    # http://stackoverflow.com/questions/14714936/fix-ruby-string-to-n-characters
    @app.para "kg #{'%-20.20s' % name}", :stroke => "#CD9"
  end

end
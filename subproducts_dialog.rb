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
      @app.flow {
        @checked = @app.check :margin => 2
        # Default weight comes from subproduct
        @weight = @app.edit_line "#{subproduct.weight}", :stroke => "#CD9", :width => 50
        print_product_name( subproduct.name )
      }
      [ @checked, @weight, subproduct]
    end

    @app.button "Select" do
      selected = @gui_selected.map do |c, weight, subproduct|
        @subproducts_selected << subproduct if c.checked?
      end
    end

  end

  def print_product_name(name)
    # http://stackoverflow.com/questions/14714936/fix-ruby-string-to-n-characters
    @app.para "kg #{'%-20.20s' % name}", :stroke => "#CD9"
  end

end
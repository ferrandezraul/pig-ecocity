$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

require 'product_helper'
require 'customer_helper'

class SubProductsDialog

  def initialize( app)
    @app = app
    @subproducts_selected = []
  end

  def subproducts=(subproducts)
    @subproducts = subproducts
    draw
  end

  def get_selected_subproducts
    if @selected
      @selected.map do |c, weight, subproduct|
        @subproducts_selected << subproduct if c.checked?
      end

      return @subproducts_selected
    else
      return []
    end

  end

  def clear
    debug( "Clearing Subproduct dialog")
    @subproducts_selected.clear
    if @selected
      @selected.each do |checkbox, weight_editor, subproduct|
        checkbox.checked = false
      end
    end
  end

  private

  def draw
    @app.para "Tria els productes del lot:", :stroke => "#CD9", :margin => 4

    @selected = @subproducts.map do |subproduct|
      @app.flow {
        @checkbox = @app.check :margin => 2
        # Default weight comes from subproduct
        @weight_editor = @app.edit_line "#{subproduct.weight}", :stroke => "#CD9", :width => 50
        print_product_name( subproduct.name )
      }
      [ @checkbox, @weight_editor, subproduct]
    end

  end

  def print_product_name(name)
    # http://stackoverflow.com/questions/14714936/fix-ruby-string-to-n-characters
    @app.para "kg #{'%-20.20s' % name}", :stroke => "#CD9"
  end

end
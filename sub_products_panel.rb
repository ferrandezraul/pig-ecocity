$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class SubProductsPanel < Shoes::Widget
  def initialize( args )
    sub_products = args[:subproducts]
    @sub_products_selected = Array.new

    stack :margin => 4 do
      border black
      para "Tria els productes del lot:", :margin => 4

      @selected = sub_products.map do |subproduct|
        flow {
          @checkbox = check :margin => 2
          # Default weight comes from subproduct
          @weight_editor = edit_line "#{subproduct.weight}", :width => 50
          para "kg #{'%-20.20s' % subproduct.name}", :margin => 4
        }
        [ @checkbox, @weight_editor, subproduct]
      end

      @button = button "Confirmar selecció", :margin => 4 do
        yield get_selected_subproducts
        disable_checkbox_and_weight
      end
    end

  end

  private

  def get_selected_subproducts
    if @selected
      @selected.map do |c, weight, subproduct|
        @sub_products_selected << subproduct if c.checked?
      end
    end

    @sub_products_selected
  end

  def reset_checkbox_and_weight
    @selected.each do |checkbox, weight_editor, subproduct|
      weight_editor.text = "#{subproduct.weight}"
      checkbox.checked = false
    end
  end

  def disable_checkbox_and_weight
    @selected.each do |checkbox, weight_editor, subproduct|
      checkbox.state = "disabled"
      weight_editor.state = "disabled"
    end
    @button.state = "disabled"
  end

end
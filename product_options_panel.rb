# encoding: UTF-8

$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class ProductOptionsPanel < Shoes::Widget
  def initialize( args )
    product_options = args[:product_options]
    @weight_required = args[:weight]
    @product_options_selected = Array.new

    stack :margin => 4 do
      border black
      para "Tria els productes del lot:", :margin => 4

      @product_options_entries = product_options.map do |product_option|
        flow {
          @checkbox = check :margin => 2
          # Default weight comes from subproduct
          @weight_editor = edit_line "#{product_option.weight}", :width => 50
          para "kg #{'%-20.20s' % product_option.name}", :margin => 4
        }
        [ @checkbox, @weight_editor, product_option]
      end

      @button = button "Confirmar selecció", :margin => 4 do
        yield [get_selected_products_options, total_weight_selected, total_weight_is_valid?]
        if total_weight_is_valid?
          disable_checkbox_and_weight
        end
      end
    end

  end

  private

  def get_selected_products_options
    if @product_options_entries
      @product_options_entries.map do |c, weight, subproduct|
        @product_options_selected << subproduct if c.checked?
      end
    end
    @product_options_selected
  end

  def reset_checkbox_and_weight
    @product_options_entries.each do |checkbox, weight_editor, subproduct|
      weight_editor.text = "#{subproduct.weight}"
      checkbox.checked = false
    end
  end

  def disable_checkbox_and_weight
    @product_options_entries.each do |checkbox, weight_editor, subproduct|
      checkbox.state = "disabled"
      weight_editor.state = "disabled"
    end
    @button.state = "disabled"
  end

  def total_weight_is_valid?
    @total_weight_selected = total_weight_selected
    weight_is_valid?( @total_weight_selected)
  end

  def total_weight_selected
    total_weight_selected = 0.0
    if @product_options_entries
      @product_options_entries.map do |checkbox, weight_editor, subproduct|
        total_weight_selected += weight_editor.text.to_f if checkbox.checked?
      end
    end

    total_weight_selected
  end

  def weight_is_valid?(weight)
    if @weight_required != weight
      false
    else
      true
    end
  end


end
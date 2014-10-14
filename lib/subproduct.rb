class SubProduct
  attr_reader :main_product
  attr_reader :weight

  def initialize(params)
    @main_product = params[:main_product]
    @weight = params[:weight]
  end

  def to_s
    # Align to the left with a size of 10 chars
    name_formatted = '%-20.20s' % @main_product.name
    p_tienda = "%4.2f" % @main_product.price_tienda.to_f
    p_coope = "%4.2f" % @main_product.price_coope.to_f
    p_pvp = "%4.2f" % @main_product.price_pvp.to_f

    price_formatted = "(#{p_tienda.to_s},#{p_coope.to_s},#{p_pvp.to_s})  EUR/KG"

    #name_formatted + price_formatted + subproducts_formatted
    name_formatted
  end

end
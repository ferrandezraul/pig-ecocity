class Product
  attr_reader :name
  attr_reader :price_tienda
  attr_reader :price_coope
  attr_reader :pvp
  attr_reader :observations
  attr_reader :subproducts

  def initialize(product)
    @name = product[:name]
    @price_tienda = product[:price_tienda]
    @price_coope = product[:price_coope]
    @pvp = product[:pvp]
    @observations = product[:observations]
    @subproducts = product[:subproducts]
  end

  def to_s
    # Align to the left with a size of 10 chars
    name_formatted = @name[0..15]
    p_tienda = "%.2f" % @price_tienda.to_f
    price_tienda_formatted = " Tienda #{p_tienda} EUR/KG"
    p_coope = "%.2f" % @price_coope.to_f
    price_coope_formatted = " Coope #{p_coope} EUR/KG"
    p_pvp = "%.2f" % @pvp.to_f
    price_pvp_formatted = " PVP #{p_pvp} EUR/KG"

    name_formatted + price_tienda_formatted + price_coope_formatted + price_pvp_formatted
  end

end
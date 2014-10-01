class Product
  attr_reader :name
  attr_reader :price_tienda
  attr_reader :price_coope
  attr_reader :pvp

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
    name_formatted = "%-100s" % @name.to_s
    price_tienda_formatted = "%50s" % "Tienda #{@price_tienda.to_f} EUR/KG"
    price_coope_formatted = "%-50s" % "Coope #{@price_coope.to_f} EUR/KG"
    price_pvp_formatted = "%-50s" % "PVP #{@pvp.to_f} EUR/KG"

    name_formatted + price_tienda_formatted + price_coope_formatted + price_pvp_formatted
  end

end
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
    "#{@name} - Tienda: #{@price_tienda} EUR/KG Coope: #{@price_coope} EUR/KG PVP: #{@pvp} EUR/KG"
  end

end
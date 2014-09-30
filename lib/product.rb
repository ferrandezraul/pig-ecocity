class Product
  attr_reader :name
  attr_reader :price
  attr_reader :price_coope
  attr_reader :pvp

  def initialize(product)
    @name = product[:name]
    @price = product[:price]
    @price_coope = product[:price_coope]
    @pvp = product[:pvp]
    @observations = product[:observations]
    @subproducts = product[:subproducts]
  end

  def to_s
    "#{@name} - #{@price} EUR/KG #{@price_coope} (COOPE) #{@pvp} EUR PVP"
  end

end
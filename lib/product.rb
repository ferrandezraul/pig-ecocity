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
    name_formatted = '%-20.20s' % @name
    p_tienda = "%4.2f" % @price_tienda.to_f
    p_coope = "%4.2f" % @price_coope.to_f
    p_pvp = "%4.2f" % @pvp.to_f

    price_formatted = "(#{p_tienda.to_s},#{p_coope.to_s},#{p_pvp.to_s})  EUR/KG"

    subproducts_formatted = ""
    @subproducts.each do |subproduct|
      subproducts_formatted += "\n\t#{subproduct.to_s}"
    end


    name_formatted + price_formatted + subproducts_formatted
  end

  def has_subproducts?
    @subproducts.empty? ? false : true
  end

end
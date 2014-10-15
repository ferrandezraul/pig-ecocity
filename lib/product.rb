class Product
  attr_reader :name
  attr_reader :price_tienda
  attr_reader :price_coope
  attr_reader :price_pvp
  attr_reader :observations
  attr_accessor :subproducts

  def initialize(params)
    @name = params[:name]
    @price_tienda = params[:price_tienda]
    @price_coope = params[:price_coope]
    @price_pvp = params[:pvp]
    @observations = params[:observations]
    @subproducts = params[:subproducts]
  end

  def to_s
    # Align to the left with a size of 10 chars
    name_formatted = '%-20.20s' % @name
    p_tienda = "%4.2f" % @price_tienda.to_f
    p_coope = "%4.2f" % @price_coope.to_f
    p_pvp = "%4.2f" % @price_pvp.to_f

    price_formatted = "(#{p_tienda.to_s},#{p_coope.to_s},#{p_pvp.to_s})  EUR/KG"

    subproducts_formatted = ""

    if has_subproducts?
      subproducts_formatted += "\n\tOpcions a escollir:\n"
      @subproducts.each do |subproduct|
        subproducts_formatted += "\t#{subproduct[:weight]} Kg\t#{subproduct[:product].to_s}\n"
      end
    end

    #name_formatted + price_formatted + subproducts_formatted
    name_formatted + subproducts_formatted
  end

  def has_subproducts?
    @subproducts.empty? ? false : true
  end

end
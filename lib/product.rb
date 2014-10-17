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
    # Align to the left with a size of 20 chars
    name_formatted = '%-20.20s' % @name

    subproducts_formatted = ""

    if has_subproducts?
      subproducts_formatted += "\n\tOpcions a escollir:\n"
      @subproducts.each do |subproduct|
        subproducts_formatted += "\t#{subproduct.weight} Kg\t#{subproduct.name}\n"
      end
    end

    name_formatted + subproducts_formatted
  end

  def has_subproducts?
    @subproducts.empty? ? false : true
  end

end
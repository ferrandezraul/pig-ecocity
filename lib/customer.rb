class Customer
  attr_reader :name
  attr_reader :address
  attr_reader :type

  def initialize(params)

    raise "Wrong customer type found" unless params[:type] =~ /CLIENT|COOPE|TIENDA/

    @name = params[:name]
    @address = params[:address]
    @type = params[:type]
  end

  def to_s
    "#{@type} #{@name} - Address: #{@address}"
  end

end
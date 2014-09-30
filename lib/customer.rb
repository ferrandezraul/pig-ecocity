class Customer
  attr_reader :name
  attr_reader :address
  attr_reader :type

  def initialize(customer)

    raise "Wrong customer type found" unless customer[:type] =~ /CLIENT|COOPE|TIENDA/

    @name = customer[:name]
    @address = customer[:address]
    @type = customer[:type]
  end

  def to_s
    "#{@type} #{@name} - Address: #{@address}"
  end

end
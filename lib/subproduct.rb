class SubProduct
  attr_reader :name
  attr_reader :weight
  attr_reader :quantity

  def initialize(params)
    @name = params[:name]
    @weight = params[:weight]
    @quantity = params[:quantity]
  end

  def to_s
    "#{@quantity} x #{@weight} #{@name}"
  end

end
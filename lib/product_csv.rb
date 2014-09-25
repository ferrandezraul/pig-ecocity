require 'csv'

module Columns
  NAME = 0            # Name
  PRICE = 1           # Price
  PRICE_COOPE = 2     # Price for cope
  PVP = 3             # PVP
  OBSERVATIONS = 4    # Observations
  SUBPRODUCTS = 5     # Sub-products
end

class ProductCSV
  #  Returns array of Product attributes
  #  = Example
  #  products = [
  #  {
  #    :name => "Costelles (0.3 kg)",
  #    :price => 8.50,
  #    :price_coope => 9.50,
  #    :pvp => 10.50,
  #    :observations => "Cuits o sense coure",
  #    :subproducts => []                       # ["0,5 kg Llom", "0,4 kg Carn picada"]
  #  }
  #]
  def self.read( file_path )

    # By default separator is ","
    # CSV.read(file_path, { :col_sep => ';' })
    products_array = CSV.read(file_path)

    products_array_clean = []
    products_array.each do |product_attributes|
      # Filter headers. Note that it is assumed that headers start with '#'
      products_array_clean.push product_attributes unless product_attributes.first.starts_with?("#")
    end

    my_products = []
    products_array_clean.each do |product_attributes|

      my_products.push( { :name => product_attributes[Columns::NAME],
                          :price => product_attributes[Columns::PRICE].to_f,
                          :price_coope => product_attributes[Columns::PRICE_COOPE].to_f,
                          :pvp => product_attributes[Columns::PVP].to_f,
                          :observations => product_attributes[Columns::OBSERVATIONS],
                          :subproducts => product_attributes[Columns::SUBPRODUCTS] } )
    end

    my_products

  end

end
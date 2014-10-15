require 'csv'
require 'product'
require 'subproduct'
require 'errors'

module Columns
  NAME = 0            # Name
  PRICE_TIENDA = 1           # Price
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
    products_array = CSV.read(file_path, encoding: "ISO8859-1")  # uses encoding: "ISO8859-1" to be able to read UTF8

    # Filter headers. Note that it is assumed that headers start with '#'
    products_array.reject! { |product_attributes| product_attributes.first.start_with?("#") }

    products_array.each { |product_attributes| verify_product_attributes( product_attributes ) }

    # Returns new array with products
    final_products = products_array.map do |product_attributes|
      subproducts = get_subproducts( product_attributes )
      Product.new( :name => product_attributes[Columns::NAME],
                   :price_tienda => product_attributes[Columns::PRICE_TIENDA].to_f,
                   :price_coope => product_attributes[Columns::PRICE_COOPE].to_f,
                   :pvp => product_attributes[Columns::PVP].to_f,
                   :observations => product_attributes[Columns::OBSERVATIONS],
                   :subproducts => subproducts )

    end

    final_products.each do |product|
      if !product.subproducts.empty?
        subproducts_list = product.subproducts
        subproducts_list.each do |subproduct|
          real_product = ProductHelper.find_product_with_name( final_products, subproduct[:name] )
          raise "Subproduct not found #{subproduct[:name]} in product #{product.name}" unless real_product
          subproduct.merge!( :product => real_product )
        end
      end
    end

  end

  private

  def self.verify_product_attributes( attributes )
    raise Errors::ProductCSVError.new, "Error loading csv. Nom de producte invalid" unless attributes[Columns::NAME]
    raise Errors::ProductCSVError.new, "Error loading csv. Preu tenda del producte #{attributes[Columns::NAME]} invalid" unless attributes[Columns::PRICE_TIENDA]
    raise Errors::ProductCSVError.new, "Error loading csv. Preu coope del producte #{attributes[Columns::NAME]} invalid" unless attributes[Columns::PRICE_COOPE]
    raise Errors::ProductCSVError.new, "Error loading csv. Preu PVP del producte   #{attributes[Columns::NAME]} invalid" unless attributes[Columns::PVP]
  end

  def self.has_subproducts?( product_attributes )
    if product_attributes[Columns::SUBPRODUCTS]
      return true
    end

    return false
  end

  def self.get_subproducts( product_attributes )
    subproducts = []
    if !has_subproducts?( product_attributes )
      return subproducts
    end

    i = 0
    while product_attributes[Columns::SUBPRODUCTS + i]
      subproduct_weight = product_attributes[Columns::SUBPRODUCTS + i]
      subproduct_name = product_attributes[Columns::SUBPRODUCTS + i + 1]

      names = []
      if subproduct_name.include?("|")
        names = subproduct_name.split("|")
      else
        names << subproduct_name
      end

      names.each do |name|
        subproducts << { :weight => subproduct_weight,
                         :name => name }
      end

      i += 2
    end

    subproducts
  end

end
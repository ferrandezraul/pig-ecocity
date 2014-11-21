$:.unshift File.join( File.dirname( __FILE__ ), "..", "lib" )

require 'test/unit'
require 'product'
require 'subproduct'

class TestProduct < Test::Unit::TestCase

  def test_constructor
    product = Product.new( :name => "Costelles",
                           :price_tienda => 10,
                           :price_coope => 12,
                           :pvp => 14,
                           :observations => "Nothing",
                           :subproducts => [ SubProduct.new( :name => "Leche", :weight => 0.2, :quantity => 1),
                                             SubProduct.new( :name => "Cacao", :weight => 0.2, :quantity => 1 ) ],
                           :price_type => Product::PriceType::POR_KILO )

    assert_equal( "Costelles", product.name )
    assert_equal( 10, product.price_tienda )
    assert_equal( 12, product.price_coope )
    assert_equal( 14, product.price_pvp )
    assert_equal( 'Nothing', product.observations )
    assert_equal( [ "Leche", "cacao" ], product.subproducts )
  end

  def test_to_s_scenario1
    product = Product.new( :name => "Costelles",
                           :price_tienda => 10,
                           :price_coope => 12,
                           :pvp => 14,
                           :observations => "Nothing",
                           :subproducts => [ SubProduct.new( :name => "Leche", :weight => 0.2, :quantity => 1),
                                             SubProduct.new( :name => "Cacao", :weight => 0.2, :quantity => 1 ) ],
                           :price_type => Product::PriceType::POR_KILO )

    assert_equal( "Costelles           (10.00,12.00,14.00)  EUR/KG", product.to_s )
  end

  def test_to_s_scenario2
    product = Product.new( :name => "Costelles super bones de porc que tenen un gust molt bo",
                           :price_tienda => 10,
                           :price_coope => 12,
                           :pvp => 14,
                           :observations => "Nothing",
                           :price_type => Product::PriceType::POR_KILO )

    assert_equal( "Costelles super bone(10.00,12.00,14.00)  EUR/KG", product.to_s )
  end

end
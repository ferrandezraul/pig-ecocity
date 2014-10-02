$:.unshift File.join( File.dirname( __FILE__ ), "..", "lib" )

require 'test/unit'
require 'product'

class TestProduct < Test::Unit::TestCase

  def test_constructor
    product = Product.new( { :name => "Costelles",
                             :price_tienda => 10,
                             :price_coope => 12,
                             :pvp => 14,
                             :observations => "Nothing",
                             :subproducts => [ "Leche", "cacao" ] } )

    assert_equal( "Costelles", product.name )
    assert_equal( 10, product.price_tienda )
    assert_equal( 12, product.price_coope )
    assert_equal( 14, product.pvp )
    assert_equal( 'Nothing', product.observations )
    assert_equal( [ "Leche", "cacao" ], product.subproducts )
  end

  def test_to_s_scenario1
    product = Product.new( { :name => "Costelles",
                             :price_tienda => 10,
                             :price_coope => 12,
                             :pvp => 14,
                             :observations => "Nothing",
                             :subproducts => [ "Leche", "cacao" ] } )

    assert_equal( "Costelles Tienda 10.00 EUR/KG Coope 12.00 EUR/KG PVP 14.00 EUR/KG", product.to_s )
  end

  def test_to_s_scenario2
    product = Product.new( { :name => "Costelles super bones de porc que tenen un gust molt bo",
                             :price_tienda => 10,
                             :price_coope => 12,
                             :pvp => 14,
                             :observations => "Nothing",
                             :subproducts => [ "Leche", "cacao" ] } )

    assert_equal( "Costelles super  Tienda 10.00 EUR/KG Coope 12.00 EUR/KG PVP 14.00 EUR/KG", product.to_s )
  end

end
require_relative 'test_helper'
require 'pry'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

def setup
	@sales_engine = SalesEngine.from_csv({
	  :items     => './test/data/items_fixture.csv',
	  :merchants => './data/merchants.csv',
	})
	@sales_engine_dos = SalesEngine.from_csv({
		:items     => './data/items.csv',
		:merchants => './data/merchants.csv',
		})
end

	def test_sales_analyst_inits
		sa = SalesAnalyst.new(@sales_engine)

		assert_instance_of SalesAnalyst, sa
		assert_instance_of SalesEngine, sa.se
	end

	def test_it_passes_through_sales_engine
		 # Unskip if running with official merchant.csv as argv[1]
		sa = SalesAnalyst.new(@sales_engine)
		merchant = sa.se.merchants.find_by_id(12334195)
		actual = merchant.items[1].name
		expected = "Course contre la montre"

		assert_equal 12, merchant.items.length
		assert_equal expected, actual
	end

	def test_average_items_per_merch_works
		#unskip if running with merchant_fixture.csv as ARGV[1]
		sa = SalesAnalyst.new(@sales_engine_dos)
		actual = sa.average_items_per_merchant
		expected = 2.88

		assert_equal expected, actual
	end

	def test_it_can_find_standard_deviation_with_fixture
			#0.09
		sa = SalesAnalyst.new(@sales_engine_dos)
		actual = sa.average_items_per_merchant_standard_deviation

		assert_equal 3.26, actual
	end

	def test_it_can_find_merchants_with_high_item_count
		sa = SalesAnalyst.new(@sales_engine)
		actual = sa.merchants_with_high_item_count
		expected = ["Shopin1901", "MiniatureBikez", "jejum", "BowlsByChris", "handicraftcallery", "Madewithgitterxx", "FlavienCouche", "BloominScents", "MuttisStrickwaren", "WellnessNeelsen", "Woodenpenshop", "TheAssemblyRooms", "SLHandmades", "Soudoveshop", "dansoilpaintings", "2MAKERSMARKET", "WoodleyShop", "Jesuisunponey", "Witoldart", "IOleynikova", "leaburrot", "ExecutiveGiftShoppe"]

		assert_equal expected, actual
	end

	def test_it_finds_average_price_per_item
		sa = SalesAnalyst.new(@sales_engine)
		actual = sa.average_item_price_for_merchant(12334195)
		expected = 44983.33

		assert_equal expected, actual.to_f.round(2)
		assert_instance_of BigDecimal, actual
	end

	def test_it_finds_average_price_per_item_with_different_item
		sa = SalesAnalyst.new(@sales_engine)
		actual = sa.average_item_price_for_merchant(12334271)
		expected = 1200.0

		assert_equal expected, actual.to_f.round(2)
		assert_instance_of BigDecimal, actual
	end

	def test_it_finds_average_price_per_item_without_item_fixture_csv
		sa = SalesAnalyst.new(@sales_engine_dos)
		actual = sa.average_item_price_for_merchant(12334213)
		expected = 1090.0

		assert_equal expected, actual.to_f.round(2)
		assert_instance_of BigDecimal, actual
	end

  def test_it_finds_the_total_average_item_price_for_all_merchants
		sa = SalesAnalyst.new(@sales_engine)
    actual = sa.average_average_price_per_merchant
		expected = 420.79

		assert_equal expected, actual.to_f.round(2)
		assert_instance_of BigDecimal, actual
	end

	def test_it_finds_the_total_average_item_price_for_all_merchants_without_item_fixture
		sa = SalesAnalyst.new(@sales_engine_dos)
    actual = sa.average_average_price_per_merchant
		expected = 35029.47

		assert_equal expected, actual.to_f.round(2)
		assert_instance_of BigDecimal, actual
	end
end

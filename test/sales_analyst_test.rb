require_relative 'test_helper'
require 'pry'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

def setup
	@sales_engine = SalesEngine.from_csv({
	  :items     => ARGV[0],
	  :merchants => ARGV[1],
	})
end

	def test_sales_analyst_inits
		sa = SalesAnalyst.new(@sales_engine)

		assert_instance_of SalesAnalyst, sa
		assert_instance_of SalesEngine, sa.se
	end

	def test_it_passes_through_sales_engine
		skip # Unskip if running with official merchant.csv as argv[1]
		sa = SalesAnalyst.new(@sales_engine)
		merchant = sa.se.merchants.find_by_id(12334194)
		actual = merchant.items[1].name
		expected = "Jolies boucles d&#39;oreilles en pâte polymère et cuir façonnées à la main"

		assert_equal 7, merchant.items.length
		assert_equal expected, actual
	end

	def test_average_items_per_merch_works
		#unskip if running with merchant_fixture.csv as ARGV[1]
		sa = SalesAnalyst.new(@sales_engine)
		actual = sa.average_items_per_merchant
		expected = 2.88

		assert_equal expected, actual
	end


end

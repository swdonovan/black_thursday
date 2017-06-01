require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require 'pry'


class SalesEngineTest < Minitest::Test

	def test_sales_engine_inits
		actual = SalesEngine.from_csv({
		  :items     => "data/items.csv",
		  :merchants => "data/merchants.csv"
		})

		assert_instance_of SalesEngine, actual
	end

	def test_merchant_method_inits
		actual = SalesEngine.from_csv({
		  :items     => "data/items.csv",
		  :merchants => "data/merchants.csv"
		})
		assert_instance_of MerchantRepository, actual.merchants
	end

	def test_items_method_inits
		actual = SalesEngine.from_csv({
		  :items     => ARGV[0],
		  :merchants => ARGV[1],
		})
		assert_instance_of ItemRepository, actual.items
	end

	

end

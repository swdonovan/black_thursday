require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require 'pry'


class SalesEngineTest < Minitest::Test

	def test_sales_engine_inits
		actual = SalesEngine.new

		assert_instance_of SalesEngine, actual
	end

	def test_merchant_method_inits
		actual = SalesEngine.from_csv({
		  :items     => ARGV[0],
		  :merchants => ARGV[1],
		})
		binding.pry
		actual.merchants

		assert_instance_of MerchantRepository, actual
	end

end

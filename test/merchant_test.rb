require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/merchant'
require 'pry'


class MerchantTest < Minitest::Test

	def test_it_exsists
		a = Merchant.new(name)
		expected = Merchant
		actual = a

		assert_instance_of expected, actual
	end

	def test_shows_correct_id
		a = Merchant.new(name)
		expected = nil
		actual = a.id

		assert_equal expected, actual
	end

	def test_it_shows_changed_id_after_find_merch_id
		a = Merchant.new(name)
		a.find_merchant_id
		expected = "12337411"
		actual = a.id

		assert_equal expected, actual
	end



end

require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require 'pry'


class MerchantTest < Minitest::Test

	def test_it_exsists
		a = Merchant.new({:id => nil, :name => nil})
		expected = Merchant
		actual = a

		assert_instance_of expected, actual
	end

	def test_shows_correct_id
		a = Merchant.new({:id => nil, :name => nil})
		actual = a.id

		assert_equal 0, actual
		assert_nil a.name
	end

	def test_shows_correct_id_again
		a = Merchant.new({:id => "123", :name => "Pablo"})
		expected = 123
		actual = a.id

		assert_equal expected, actual
		assert_equal "Pablo", a.name
	end

	def test_shows_correct_id_still
		a = Merchant.new({:id => "9923123", :name => "Pablo's brother Jake"})
		expected = 9923123
		actual = a.id

		assert_equal expected, actual
		assert_equal "Pablo's brother Jake", a.name
	end

	def test_shows_correct_id_one_more_time
		a = Merchant.new({:id => "169", :name => "Chen"})
		expected = 169
		actual = a.id

		assert_equal expected, actual
		assert_equal "Chen", a.name
	end

	def test_shows_correct_id_jk_still_gots_another
		a = Merchant.new({:id => "a million", :name => "a billion"})
		expected = 0
		actual = a.id

		assert_equal expected, actual
		assert_equal "a billion", a.name
	end
end

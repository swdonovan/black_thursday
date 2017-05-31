require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require 'pry'


class MerchantRepositoryTest < Minitest::Test

	def test_it_exsists
		a = MerchantRepository.new(name)
		expected = MerchantRepository
		actual = a

		assert_instance_of expected, actual
	end

	def test_shows_correct_id
		a = MerchantRepository.new(name)
		expected = nil
		actual = a.id

		assert_nil actual
	end

	def test_it_shows_changed_id_after_find_merch_id
		skip
		a = MerchantRepository.new(name)
		a.find_merchant_id
		expected = "12337411"
		actual = a.id

		assert_equal expected, actual
	end

	def test_shows_correct_name
		a = MerchantRepository.new(name)
		actual = a.name

		assert_nil actual
	end

	def test_it_shows_name
		a = MerchantRepository.new(name)
		b = a.find_by_name("CJsDecor")
		actual = b.name
		expected = "CJsDecor"

		assert_equal expected, actual
	end


end

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

	def test_items_methods_pass_through
		a = SalesEngine.from_csv({
		  :items     => ARGV[0],
		  :merchants => ARGV[1],
		})
		b = a.items.find_by_id("263395237")
		actual = b.id
		expected = "263395237"

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_dif_id
		a = SalesEngine.from_csv({
		  :items     => ARGV[0],
		  :merchants => ARGV[1],
		})
		b = a.items.find_by_id("263567376")
		actual = b.id
		expected = "263567376"

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_diff_id
		a = SalesEngine.from_csv({
		  :items     => ARGV[0],
		  :merchants => ARGV[1],
		})
		b = a.items.find_by_id("263567242")
		actual = b.id
		expected = "263567242"

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_different_id
		a = SalesEngine.from_csv({
		  :items     => ARGV[0],
		  :merchants => ARGV[1],
		})
		b = a.items.find_by_id("12337411")
		actual = b

		assert_nil actual
	end

	def test_items_methods_pass_through__id
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_by_id("1")
		actual = b

		assert_nil actual
	end

	def test_items_methods_pass_through_for_name
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_by_name("510+ RealPush Icon Set")
		actual = b.name
		expected = "510+ RealPush Icon Set"

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_name_crazy_case
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_by_name("510+ RealPUSh IcOn SEt")
		actual = b.name
		expected = "510+ RealPush Icon Set"

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_partial_descrtiption
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b  = a.items.find_all_with_description("hard monster spray")
    actual = b[0].id if b[0] != nil

		assert_nil actual
	end

	def test_items_methods_pass_through_for_partial_descrtiption_nil
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b  = a.items.find_all_with_description("hard monster spray")
		actual = b[0].id if b[0] != nil

		assert_nil actual
	end

	def test_items_methods_pass_through_for_partial_descrtiption_return_value
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_all_with_description("soft drugs prejudices")
		actual = b[0].id if b[0] != nil
    expected = "263402475"

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_all_price_find
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_all_by_price("1200")
    actual = b[0].unit_price
    expected = "1200"

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_find_all_by_price
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_all_by_price("0")
    actual = b
    expected = []

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_find_all_prices
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_all_by_price("3000")
    actual = b[0].name
    expected = "Moyenne toile"

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_merchant_id
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_by_merchant_id("12334194")
    actual = b.name
    expected = "Superbe plastron tout en pâte polymère texturée"

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_merchant_id_nil
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_by_merchant_id("1")
		actual = b
		expected = []

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_price_range
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		b = a.items.find_all_by_price_in_range(2000, 5000)
    first_name  = b[0].name
    second_name = b[1].name
    third_name  = b[2].name
    actual = [first_name, second_name, third_name]
    expected = ["Vogue Paris Original Givenchy 2307", "Wooden pen and stand", "HOT Crystal Dragon Fly Hand Blown Glass Art Gold Trim Figurine Lucky Collection"]

    assert_equal 427, b.length
    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_price_range_nil
		a = SalesEngine.from_csv({
			:items     => ARGV[0],
			:merchants => ARGV[1],
		})
		actual = a.items.find_all_by_price_in_range(1, 2)
		expected = []

		assert_equal expected, actual
	end
end

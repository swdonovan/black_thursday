require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'time'
require 'pry'


class SalesEngineTest < Minitest::Test

	def setup
		@se_uno = SalesEngine.from_csv({
			:items         => "./data/items.csv",
		  :merchants     => "./data/merchants.csv",
		  :invoices      => "./data/invoices.csv",
		  :invoice_items => "./data/invoice_items.csv",
		  :transactions  => "./data/transactions.csv",
		  :customers     => "./data/customers.csv"
			})

		# @se_file = SalesEngine.from_csv({
		# 	:item => ARGV[0],
		# 	:merchants => ARGV[1],
		# 	:invoices => ARGV[2]
		# 	})
	end

	def test_sales_engine_inits
		actual = @se_uno

		assert_instance_of SalesEngine, actual
	end

	def test_merchant_method_inits
		actual = @se_uno
		assert_instance_of MerchantRepository, actual.merchants
	end

	def test_items_method_inits
		actual = @se_uno
		assert_instance_of ItemRepository, actual.items
	end

	def test_invoices_method_inits
		actual = @se_uno
		assert_instance_of InvoiceRepository, actual.invoices
	end

	def test_invoice_items_method_inits
		actual = @se_uno
		assert_instance_of InvoiceItemRepository, actual.invoice_items
	end

	def test_transactions_method_inits
		actual = @se_uno
		assert_instance_of TransactionRepository, actual.transactions
	end

	def test_customers_method_inits
		actual = @se_uno
		assert_instance_of CustomerRepository, actual.customers
	end

	def test_items_methods_pass_through
		a = @se_uno
		b = a.items.find_by_id("263395237")
		actual = b.id
		expected = 263395237

		assert_equal expected, actual
	end

	def test_items_methods_pass_through
		a = @se_uno
		b = a.items.find_by_id("263395237")
		actual = b.name
		expected = "510+ RealPush Icon Set"

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_dif_id
		a = @se_uno
		b = a.items.find_by_id("263567376")
		actual = b.id
		expected = 263567376

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_diff_id
		a = @se_uno
		b = a.items.find_by_id("263567242")
		actual = b.id
		expected = 263567242

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_different_id
		a = @se_uno
		b = a.items.find_by_id("12337411")
		actual = b

		assert_nil actual
	end

	def test_items_methods_pass_through__id
		a = @se_uno
		b = a.items.find_by_id(12334112)
		actual = b

		assert_nil actual
	end

	def test_items_methods_pass_through_for_name
		a = @se_uno
		b = a.items.find_by_name("510+ RealPush Icon Set")
		actual = b.name
		expected = "510+ RealPush Icon Set"

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_name_crazy_case
		a = @se_uno
		b = a.items.find_by_name("510+ RealPUSh IcOn SEt")
		actual = b.name
		expected = "510+ RealPush Icon Set"

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_partial_descrtiption
		a = @se_uno
		b  = a.items.find_all_with_description("hard monster spray")
    actual = b[0].id if b[0] != nil

		assert_nil actual
	end

	def test_items_methods_pass_through_for_partial_descrtiption_nil
		a = @se_uno
		b  = a.items.find_all_with_description("hard monster spray")
		actual = b[0].id if b[0] != nil

		assert_nil actual
	end

	def test_items_methods_pass_through_for_partial_descrtiption_return_value
		a = @se_uno
		b = a.items.find_all_with_description("soft drugs prejudices")
		actual = b[0].id if b[0] != nil
    expected = 263402475

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_all_price_find
		a = @se_uno
		b = a.items.find_all_by_price("1200")
    actual = b[0].unit_price_to_dollars
    expected = 1200.0

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_find_all_by_price
		a = @se_uno
		b = a.items.find_all_by_price("0")
    actual = b
    expected = []

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_find_all_prices
		a = @se_uno
		b = a.items.find_all_by_price("30")
    actual = b[0].name
    expected = "Moyenne toile"

    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_merchant_id
		a = @se_uno
		b = a.items.find_all_by_merchant_id("12334194")
    actual = b[0].name
    expected = "Boucles d&#39;oreilles en pâte polymère texturée - Argent 925/1000"

    assert_equal expected, actual
		assert_equal 7, b.length
	end

	def test_items_methods_pass_through_for_merchant_id_nil
		a = @se_uno
		b = a.items.find_all_by_merchant_id("1")
		actual = b
		expected = []

		assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_price_range
		a = @se_uno
		b = a.items.find_all_by_price_in_range(2000..3000)
    actual = [(b[0].name), (b[1].name), (b[3].name), (b[4].name), (b[5].name)]
    expected = ["INFRAROUGE", "Plato Botanero Halcon Milenario hecho en nogal de 2 pulgadas de grosor", "Bibliothèque CACTUS", "Hope number 2", "Little Round Paua Abalone Stud Earrings"]

    assert_equal 6, b.length
    assert_equal expected, actual
	end

	def test_items_methods_pass_through_for_price_range_nil
		a = @se_uno
		b = a.items.find_all_by_price_in_range(1..2)
		actual = b[0].name
		expected = "Custom LEGO Alien Minion - INSTRUCTIONS ONLY"

		assert_equal expected, actual
		assert_equal 10, b.length
	end

	def test_merchants_methods_pass_through_for_find_by_name
		a = @se_uno
		b = a.merchants.find_by_name("GoldenRayPress")
		actual = b.name
		expected = "GoldenRayPress"

		assert_equal expected, actual
	end

	def test_merchants_methods_pass_through_for_find_by_name_nil
		a = @se_uno
		actual = a.merchants.find_by_name("Craigers")

		assert_nil actual
	end

	def test_merchant_methods_pass_through_for_find_by_id
		a = @se_uno
		b = a.merchants.find_by_id(12337411)
		actual = b.name
		expected = "CJsDecor"

		assert_equal expected, actual
	end

	def test_merchant_methods_pass_through_for_find_with_id
		a = @se_uno
		b = a.merchants.find_by_id(12337411)
		actual = b.name
		expected = "CJsDecor"

		assert_equal expected, actual
	end

	def test_merchant_methods_pass_through_for_find_id_instance
		a = @se_uno
		b = a.merchants.find_by_id(12334843)
		actual = b.name
		expected = "TeriTrendyTreasures"

		assert_equal expected, actual
	end

	def test_merchant_methods_pass_through_for_find_id_specific
		a = @se_uno
		b = a.merchants.find_by_id(1)
		actual = b


		assert_nil actual
	end

	def test_merch_find_id_then_finds_items_for_that_merchant
		a = @se_uno
		b = a.merchants.find_by_id(12334141)
		actual = b.items.length
		expected = 1

		assert_equal expected, actual
	end

	def test_merch_find_id_then_finds_items_for_that_merchant_again
		a = @se_uno
		b = a.merchants.find_by_id(12334194)
		actual = b.items[1].name
		expected = "Jolies boucles d&#39;oreilles en pâte polymère et cuir façonnées à la main"

		assert_equal "Lnjewelscreation", b.name
		assert_equal expected, actual
	  assert_equal 7, b.items.length
	end

	def test_item_find_id_then_finds_merchant_id
		a = @se_uno
		b = a.items.find_by_id(263395237)
		actual = b.merchant.name
		expected = "jejum"

		assert_equal expected, actual
  end

	def test_item_find_id_then_finds_merchant_id_again
		a = @se_uno
		b = a.items.find_by_id(263397201)
		actual = b.merchant.name
		expected = "WellnessNeelsen"

		assert_equal expected, actual
  end

	def test_it_can_find_invoices_by_id
		a = @se_uno
		b = a.merchants.find_by_id(12334159)
		actual = b.invoices

		assert 3, actual.length
	end

	def test_can_find_merchant_from_invoice_id
		a = @se_uno
		b = a.invoices.find_by_id(20)
		actual = b.merchant
		expected = "RnRGuitarPicks"

		assert_equal expected, actual.name
	end

	def test_can_find_items_from_invoice_id
		a = @se_uno
		b = a.invoices.find_by_id(20)
		actual = b.items
		expected = Array

		assert_equal expected, actual.class
		assert_equal 5, actual.length
		assert_equal Item, actual[1].class
		assert_equal Item, actual[4].class
		assert_equal "Magick Pain Lotion/Body Butter 1.5 oz", actual[1].name
		assert_equal "Hand Painted Confetti Wine Glass", actual[4].name
	end

	def test_can_find_transactions_from_invoice_id
		a = @se_uno
		b = a.invoices.find_by_id(20)
		actual = b.transactions
		expected = Array

		assert_equal expected, actual.class
		assert_equal 3, actual.length
		assert_equal Transaction, actual[1].class
		assert_equal Transaction, actual[2].class
		assert_equal "4363584547318205", actual[1].credit_card_number
		assert_equal "success", actual[2].result
	end

	def test_can_find_customer_from_invoice_id
		a = @se_uno
		b = a.invoices.find_by_id(20)
		actual = b.customer
		expected = Customer

		assert_equal expected, actual.class
		assert_equal "Sylvester", actual.first_name
		assert_equal "Nader", actual.last_name
	end

	def test_can_find_customer_from_invoice_id
		a = @se_uno
		b = a.invoices.find_by_id(3)
		actual = b.customer
		expected = Customer

		assert_equal expected, actual.class
		assert_equal "Joey", actual.first_name
		assert_equal "Ondricka", actual.last_name
	end

	def test_can_find_invoice_from_invoice_id_in_transactions
		a = @se_uno
		b = a.transactions.find_by_id(40)
		actual = b.invoice
		expected = Invoice

		assert_equal expected, actual.class
		assert_equal 3, actual.customer_id
		assert_equal :pending, actual.status
	end

	def test_can_find_customers_from_merchant_id_in_merchants
		a = @se_uno
		b = a.merchants.find_by_id(12335938)
		actual = b.customers
		expected = Array

		assert_equal expected, actual.class
		assert_equal 16, actual.length
		assert_equal Customer, actual[0].class
		assert_equal "Joey", actual[0].first_name
	end

	def test_can_find_merchants_from_customer_id_in_customers
		a = @se_uno
		b = a.customers.find_by_id(30)
		actual = b.merchants
		expected = Array

		assert_equal expected, actual.class
		assert_equal 5, actual.length
		assert_equal Merchant, actual[0].class
		assert_equal "SweetheartDarling", actual[0].name
		assert_equal "thepurplepenshop", actual[4].name
	end

	def test_an_invoice_can_check_if_it_is_paid_in_full
		a = @se_uno
		b = a.invoices.find_by_id(20)
		actual = b.is_paid_in_full?

		assert actual
	end

	def test_an_invoice_can_check_if_it_is_paid_in_full_and_be_false
		a = @se_uno
		b = a.invoices.find_by_id(3560)
		actual = b.is_paid_in_full?

		refute actual
	end
end

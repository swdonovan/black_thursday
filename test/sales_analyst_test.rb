require_relative 'test_helper'
require 'pry'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

def setup
	@sales_engine = SalesEngine.from_csv({
	  :items     => './test/data/items_fixture.csv',
	  :merchants => './data/merchants.csv',
		:invoices   => './test/data/invoice_fixture.csv',
		:invoice_items => "./data/invoice_items.csv",
		:transactions  => "./test/data/transactions_fixture.csv",
		:customers     => "./test/data/customers_fixture.csv"
	})
	@sales_engine_dos = SalesEngine.from_csv({
		:items         => "./data/items.csv",
		:merchants     => "./data/merchants.csv",
		:invoices      => "./data/invoices.csv",
		:invoice_items => "./data/invoice_items.csv",
		:transactions  => "./data/transactions.csv",
		:customers     => "./data/customers.csv"
		})
end

	# def test_sales_analyst_inits
	#
	# 	sa = SalesAnalyst.new(@sales_engine)
	#
	# 	assert_instance_of SalesAnalyst, sa
	# 	assert_instance_of SalesEngine, sa.se
	# end
	#
	# def test_it_passes_through_sales_engine
	#
	# 	 # Un if running with official merchant.csv as argv[1]
	# 	sa = SalesAnalyst.new(@sales_engine)
	# 	merchant = sa.se.merchants.find_by_id(12334195)
	# 	actual = merchant.items[1]
	# 	expected = "Course contre la montre"
	#
	# 	assert_equal 12, merchant.items.length
	# 	assert_equal expected, actual.name
	# 	assert_instance_of Item, actual
	# end
	#
	# def test_average_items_per_merch_works
	#
	# 	#un if running with merchant_fixture.csv as ARGV[1]
	# 	sa = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = sa.average_items_per_merchant
	# 	expected = 2.88
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_standard_deviation_without_fixture
	#
	# 		#0.09
	# 	sa = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = sa.average_items_per_merchant_standard_deviation
	#
	# 	assert_equal 3.26, actual
	# end
	#
	# def test_it_can_find_merchants_with_high_item_count
	#
	# 	sa = SalesAnalyst.new(@sales_engine)
	# 	actual = sa.merchants_with_high_item_count
	# 	expected = 22
	#
	# 	assert_equal expected, actual.length
	# 	assert_equal "Shopin1901", actual[0].name
	# 	assert_equal "SLHandmades", actual[12].name
	# 	assert_equal "ExecutiveGiftShoppe", actual[21].name
	# end
	#
	# def test_it_can_find_merchants_with_high_item_count_without_fixture
	#
	# 	sa = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = sa.merchants_with_high_item_count
	# 	expected = 52
	#
	# 	assert_equal expected, actual.length
	# 	assert_equal "Keckenbauer", actual[0].name
	# 	assert_equal "JamesCByrneART", actual[25].name
	# 	assert_equal "JewelleAccessories", actual[51].name
	# end
	#
	#
	# def test_it_finds_average_price_per_item
	#
	# 	sa = SalesAnalyst.new(@sales_engine)
	# 	actual = sa.average_item_price_for_merchant(12334195)
	# 	expected = 449.83
	#
	# 	assert_equal expected, actual.to_f.round(2)
	# 	assert_instance_of BigDecimal, actual
	# end
	#
	# def test_it_finds_average_price_per_item_with_different_item
	#
	# 	sa = SalesAnalyst.new(@sales_engine)
	# 	actual = sa.average_item_price_for_merchant(12334271)
	# 	expected = 12.0
	#
	# 	assert_equal expected, actual.to_f.round(2)
	# 	assert_instance_of BigDecimal, actual
	# end
	#
	# def test_it_finds_average_price_per_item_without_item_fixture_csv
	#
	# 	sa = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = sa.average_item_price_for_merchant(12334213)
	# 	expected = 10.90
	#
	# 	assert_equal expected, actual.to_f.round(2)
	# 	assert_instance_of BigDecimal, actual
	# end
	#
  # def test_it_finds_the_total_average_item_price_for_all_merchants
	#
	# 	sa = SalesAnalyst.new(@sales_engine)
  #   actual = sa.average_average_price_per_merchant
	# 	expected = 4.21
	#
	# 	assert_equal expected, actual.to_f.round(2)
	# 	assert_instance_of BigDecimal, actual
	# end
	#
	# def test_it_finds_the_total_average_item_price_for_all_merchants_without_item_fixture
	#
	# 	sa = SalesAnalyst.new(@sales_engine_dos)
  #   actual = sa.average_average_price_per_merchant
	# 	expected = 350.29
	#
	# 	assert_equal expected, actual.to_f.round(2)
	# 	assert_instance_of BigDecimal, actual
	# end
	#
	# def test_it_finds_golden_items_which_are_more_than_2_st_dev_away
	#
	# 	sa = SalesAnalyst.new(@sales_engine)
  #   actual = sa.golden_items
	# 	expected = "Course contre la montre"
	#
	# 	assert_equal expected, actual[0].name
	# 	assert_instance_of Array, actual
	# 	assert_instance_of Item, actual[0]
	# 	assert_equal "Introspection virginalle", actual[1].name
	# 	assert_equal "Les raisons", actual[6].name
	# end
	#
	# def test_it_finds_golden_items_which_are_more_than_2_st_dev_away
	#
	# 	sa = SalesAnalyst.new(@sales_engine_dos)
  #   actual = sa.golden_items
	# 	expected = "Test listing"
	#
	# 	assert_equal expected, actual[0].name
	# 	assert_instance_of Array, actual
	# 	assert_instance_of Item, actual[0]
	# 	assert_equal "Solid American Black Walnut Trestle Table", actual[4].name
	# 	assert_equal 5, actual.length
	# end
	#
	# def test_it_can_find_average_invoices_per_merchant
	#
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.average_invoices_per_merchant
	# 	expected = 10.49
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_average_invoices_per_merchant_standard_deviation
	#
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.average_invoices_per_merchant_standard_deviation
	# 	expected = 3.29
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_fixture_average_invoices_per_merchant_standard_deviation
	#
	# 	a = SalesAnalyst.new(@sales_engine)
	# 	actual = a.average_invoices_per_merchant_standard_deviation
	# 	expected = 0.65
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_top_merchant_invoice_count_method
	#
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.top_merchants_by_invoice_count
	# 	expected = 12
	#
	# 	assert_equal expected, actual.length
	# end
	#
	# def test_fixture_top_merchant_invoice_count_method
	#
	# 	a = SalesAnalyst.new(@sales_engine)
	# 	actual = a.top_merchants_by_invoice_count
	# 	expected = 34
	#
	# 	assert_equal expected, actual.length
	# end
	#
	# def test_bottom_merchant_invoice_count_method
	#
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.bottom_merchants_by_invoice_count
	# 	expected = 4
	#
	# 	assert_equal expected, actual.length
	# end
	#
	# def test_fixture_bottom_merchant_invoice_count_method
	#
	# 	a = SalesAnalyst.new(@sales_engine)
	# 	actual = a.bottom_merchants_by_invoice_count
	# 	expected = 0
	#
	# 	assert_equal expected, actual.length
	# end
	#
	# def test_sa_can_find_high_invoice_days
	#
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.top_days_by_invoice_count
	# 	expected = ["Wednesday"]
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_sa_can_find_high_invoice_days_with_fixture
	#
	# 	a = SalesAnalyst.new(@sales_engine)
	# 	actual = a.top_days_by_invoice_count
	# 	expected = ["Friday"]
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_invoice_status_percentage
	#
	# 	a = SalesAnalyst.new(@sales_engine)
	# 	actual = a.invoice_status(:pending)
	# 	expected = 29.0
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_invoice_status_percentage_for_shipped
	#
	# 	a = SalesAnalyst.new(@sales_engine)
	# 	actual = a.invoice_status(:shipped)
	# 	expected = 59.5
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_invoice_status_percentage_without_fixture_pending
	#
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.invoice_status(:pending)
	# 	expected = 29.55
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_invoice_status_percentage_without_fixture_shipped
	#
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.invoice_status(:shipped)
	# 	expected = 56.95
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_invoice_status_percentage_without_fixture_returned
	#
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.invoice_status(:returned)
	# 	expected = 13.5
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_top_buyers
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.top_buyers(30)
	# 	expected = "Molly Gleichner"
	#
	# 	assert_equal expected, actual[0]
	# 	assert_equal 30, actual.length
	# end
	#
	# def test_it_can_find_top_buyers_for_set_number
	# 	a = SalesAnalyst.new(@sales_engine)
	# 	actual = a.top_buyers(5)
	# 	expected = "Parker Daugherty"
	#
	# 	assert_equal expected, actual[0]
	# 	assert_equal 5, actual.length
	# end
	#
	# def test_it_can_find_top_merchant_for_customer
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.top_merchant_for_customer(5)
	# 	expected = "katieelizabethcrafts"
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_top_merchant_for_customer_764
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.top_merchant_for_customer(764)
	# 	expected = "PaulMagi"
	#
	# 	assert_equal expected, actual
	# end
	#
	# def test_it_can_find_top_merchant_for_customer_988
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.top_merchant_for_customer(988)
	# 	expected = "esellermart"
	#
	# 	assert_equal expected, actual
	# end

	def test_it_can_find_one_time_buyers
		a = SalesAnalyst.new(@sales_engine_dos)
		actual = a.one_time_buyers
		expected = ['harry']

		assert_equal expected, actual
	end

	# def test_it_can_find_one_time_buyers_length
	# 	a = SalesAnalyst.new(@sales_engine_dos)
	# 	actual = a.one_time_buyers
	#
	# 	assert_equal 3, actual.length
	# end

end

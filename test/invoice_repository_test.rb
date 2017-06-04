require 'time'
require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'


class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice_spec_file = InvoiceRepository.new('./data/invoices.csv', SalesEngine)
		@invoice_fixture = InvoiceRepository.new('./test/data/invoice_fixture.csv', SalesEngine)
  end

	def test_it_exists
		assert_instance_of InvoiceRepository, @invoice_spec_file
	end

	def test_it_returns_array_of_all_invoices
		actual = @invoice_spec_file

		refute nil, actual.all
		assert_equal 4985, actual.all.length
		assert_equal :pending, actual.all[0].status
	end

	def test_it_can_find_by_id
		a = @invoice_spec_file
		actual = a.find_by_id(6)
		expected = 12334389

		assert_instance_of Invoice, actual
		assert_equal 1, actual.customer_id
		assert_equal expected, actual.merchant_id
	end

	def test_find_id_if_nil
		a = @invoice_spec_file
		actual = a.find_by_id(nil)

		assert_nil actual
	end

	def test_if_number_doesnt_exsist
		a = @invoice_spec_file
		actual = a.find_by_id(5000)

		assert_nil actual
	end

	def test_it_finds_customer_id
		a = @invoice_spec_file
		actual = a.find_all_by_customer_id(49)

		assert_equal 257, actual[0].id
		assert_equal 258, actual[1].id
		assert_equal 2, actual.length
	end

	def test_it_finds_all_by_merchant_id
		a = @invoice_spec_file
		actual = a.find_all_by_merchant_id(12334389)

		assert_equal 6, actual[0].id
		assert_equal 15, actual.length
	end

	def test_it_finds_all_by_status
		a = @invoice_spec_file
		actual = a.find_all_by_status(:pending)
		actual_2 = a.find_all_by_status(:shipped)
		actual_3 = a.find_all_by_status(:returned)
		all_actual = (actual.length + actual_2.length + actual_3.length)

		assert_equal 1473, actual.length
		assert_equal 48, actual[15].id
		assert_equal 4985, all_actual
	end

	# def test_it_can_find_average_invoices_per_merchant_fixture
	# 	a = @invoice_fixture
	# 	actual = a.average_invoices_per_merchant
	#
	#
	# 	assert_equal 10.49, actual
	# end

end

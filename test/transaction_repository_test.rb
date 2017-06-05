require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require 'time'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @trr = TransactionRepository.new('./data/transactions.csv', SalesEngine)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, setup
  end

  def test_it_returns_all
    actual = @trr.all
    expected = 4985

    assert_equal expected, actual.length
    assert_instance_of Array, actual
    assert_equal "4068631943231473", actual[0].credit_card_number
    assert_equal "success", actual[4000].result
    assert_equal 46, actual[45].id
  end

  def test_it_can_find_by_id
		a = setup
		actual = a.find_by_id(6)
		expected = "success"

		assert_instance_of Transaction, actual
		assert_equal "0417", actual.credit_card_expiration_date
		assert_equal expected, actual.result
	end

  def test_find_id_if_nil
		a = setup
		actual = a.find_by_id(nil)

		assert_nil actual
	end

	def test_if_number_doesnt_exsist
		a = setup
		actual = a.find_by_id(1000005000)

		assert_nil actual
	end

  def test_it_finds_all_by_invoice_id
		a = setup
		actual = a.find_all_by_invoice_id(7)

		assert_equal 4916, actual[0].id
		assert_equal 1, actual.length
	end

  def test_it_finds_all_by_invoice_id_again
		a = setup
		actual = a.find_all_by_invoice_id(750)

		assert_equal 3, actual[0].id
		assert_equal 2, actual.length
	end

  def test_it_finds_all_by_crea
		a = setup
		actual = a.find_all_by_credit_card_number("4890371279632775")

		assert_equal 20, actual[0].id
		assert_equal 1, actual.length
	end

  def test_it_finds_all_by_crea_again
		a = setup
		actual = a.find_all_by_credit_card_number("4841404241773918")

		assert_equal 237, actual[0].id
		assert_equal 1, actual.length
	end
end

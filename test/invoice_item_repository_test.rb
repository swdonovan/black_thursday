require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require 'time'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @iir = InvoiceItemRepository.new('./data/invoice_items.csv', SalesEngine)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, setup
  end

  def test_it_returns_all
    actual = @iir.all
    expected = 21830

    assert_equal expected, actual.length
    assert_instance_of Array, actual
    assert_equal 1, actual[0].id
    assert_equal 5001, actual[5000].id
  end

  def test_it_can_find_by_id
    a = setup
    actual = a.find_by_id(6)
    expected = 1

    assert_instance_of InvoiceItem, actual
    assert_equal 5, actual.quantity
    assert_equal expected, actual.invoice_id
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

  def test_it_finds_item_id
    a = setup
    actual = a.find_all_by_item_id(263438971)

    assert_equal 12, actual[0].id
    assert_equal 1331, actual[1].id
    assert_equal 12, actual.length
  end

  def test_it_finds_all_by_invoice_id
    a = setup
    actual = a.find_all_by_invoice_id(7)

    assert_equal 34, actual[0].id
    assert_equal 4, actual.length
  end
end

require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'
require 'time'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @cstr = CustomerRepository.new('./data/customers.csv', SalesEngine)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, setup
  end

  def test_it_returns_all
    actual = @cstr.all
    expected = 1000

    assert_equal expected, actual.length
    assert_instance_of Array, actual
    assert_equal "Joey", actual[0].first_name
    assert_equal "Langworth", actual[999].last_name
    assert_equal 46, actual[45].id
  end

  def test_it_can_find_by_id
		a = setup
		actual = a.find_by_id(6)
		expected = "Heber"

		assert_instance_of Customer, actual
		assert_equal Time, actual.created_at.class
		assert_equal expected, actual.first_name
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

  def test_it_finds_all_by_first
		a = setup
		actual = a.find_all_by_first_name("Felipe")

		assert_equal 21, actual[0].id
		assert_equal 1, actual.length
	end

  def test_it_finds_all_by_first_name_again
		a = setup
		actual = a.find_all_by_first_name("Joey")

		assert_equal 1, actual[0].id
		assert_equal 1, actual.length
	end

  def test_it_finds_all_by_last
		a = setup
		actual = a.find_all_by_last_name("Frami")

		assert_equal 427, actual[0].id
		assert_equal 4, actual.length
	end

  def test_it_finds_all_by_last_name_again
		a = setup
		actual = a.find_all_by_last_name("Funk")

		assert_equal 167, actual[0].id
		assert_equal 2, actual.length
	end

  def test_it_finds_all_by_last_name_again_with_non_match
    a = setup
    actual = a.find_all_by_last_name("tacos!")

    assert_equal [], actual
  end
end

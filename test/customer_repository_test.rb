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
end

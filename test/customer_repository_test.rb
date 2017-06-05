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
end

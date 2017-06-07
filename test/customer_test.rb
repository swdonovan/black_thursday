require_relative 'test_helper'
require_relative '../lib/customer'
require 'time'

class CustomerTest < Minitest::Test

  def setup
    @c_1 = Customer.new({
      :id => 1,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
      }, self)

    @c_2 = Customer.new({
      :id => 6,
      :first_name => "Wil",
      :last_name => "Donovan",
      :created_at => Time.now,
      :updated_at => Time.now
      }, self)

    @c_3 = Customer.new({
      :id => 2,
      :first_name => "The",
      :last_name => "Shakira",
      :created_at => Time.now,
      :updated_at => Time.now
      }, self)
  end

  def test_it_exists
    assert_instance_of Customer, @c_1
    assert_instance_of Customer, @c_2
    assert_instance_of Customer, @c_3
  end

  def test_ii_1
    assert_equal 1, @c_1.id
    assert_equal "Joan", @c_1.first_name
    assert_equal "Clarke", @c_1.last_name
    assert_equal Time, @c_1.created_at.class
    assert_equal Time, @c_1.updated_at.class
  end

  def test_ii_2
    assert_equal 6, @c_2.id
    assert_equal "Wil", @c_2.first_name
    assert_equal "Donovan", @c_2.last_name
    assert_equal Time, @c_2.created_at.class
    assert_equal Time, @c_2.updated_at.class
  end

  def test_ii_3
    assert_equal 2, @c_3.id
    assert_equal "The", @c_3.first_name
    assert_equal "Shakira", @c_3.last_name
    assert_equal Time, @c_3.created_at.class
    assert_equal Time, @c_3.updated_at.class
  end
end

require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require 'time'

class ItemTest < Minitest::Test

  def test_it_exists
    a = Item.new({:name => "Mark", :id => '123', :description => 'abc',
      :unit_price => '123', :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => '453'}, 'holder')
    expected = Item
    actual = a

    assert_instance_of expected, actual
  end

  def test_it_shows_the_correct_name_when_passed_through
    a = Item.new({:name => "Mark", :id => "345", :description => "345",
      :unit_price => "345", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => "345"}, 'holder')
    expected = "Mark"
    actual = a.name
    assert_equal expected, actual
  end

  def test_it_shows_the_correct_different_name_when_passed_through
    a = Item.new({:name => "Alice", :id => '435', :description => '435',
      :unit_price => '435', :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => '435'}, 'holder')
    expected = "Alice"
    actual = a.name

    assert_equal expected, actual
  end

  def test_it_shows_the_right_name_when_passed_through_again
    a = Item.new({:name => "Tyler", :id => 3454, :description => 3454,
      :unit_price => 3454, :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => 3454}, 'holder')
    expected = "Tyler"
    actual = a.name
    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_through
    a = Item.new({:name => "Tyler", :id => "1234", :description => 1234,
      :unit_price => 1234, :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => 1234}, 'holder')
    expected = 1234
    actual = a.id

    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_through_again
    a = Item.new({:name => "Tyler", :id => "5280", :description => 'heies',
      :unit_price => 'heies', :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => 'heies'}, 'holder')
    expected = 5280
    actual = a.id

    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_a_million
    a = Item.new({:name => "Tyler", :id => "a million", :description => 'a',
      :unit_price => '1234', :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => 123}, 'holder')
    expected = 0
    actual = a.id

    assert_equal expected, actual
  end

  def test_it_shows_the_right_information_passed_through_at_initialize
    a = Item.new({:name => "Tyler", :id => "a million", :description => "Monster Spray",
      :unit_price => "more than you can afford", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => "Prince smbol"}, 'holder')

    assert_equal "Tyler", a.name
    assert_equal 0, a.id
    assert_equal "Monster Spray", a.description
    assert_instance_of BigDecimal, a.unit_price
    assert_equal 0.0,  a.unit_price.to_f
    assert_equal "2016-01-11 11:51:37 UTC", a.created_at.to_s
    assert_equal "2016-01-11 11:51:37 UTC", a.updated_at.to_s
    assert_equal 0, a.merchant_id
  end

  def test_it_shows_the_right_information_passed_different_info
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "40000", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => "56843166496526862"}, 'holder')

    assert_equal "Bruce", a.name
    assert_equal 685521578, a.id
    assert_equal "Not avaliable", a.description
    assert_instance_of BigDecimal, a.unit_price
    assert_equal 400.0, a.unit_price.to_f
    assert_equal 401.0, (a.unit_price + 1)
    assert_equal "2016-01-11 11:51:37 UTC", a.created_at.to_s
    assert_equal "2016-01-11 11:51:37 UTC", a.updated_at.to_s
    assert_equal 56843166496526862, a.merchant_id
  end

  def test_unit_price_to_dollars_correctly_converts_to_float
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "40000", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => "56843166496526862"}, 'holder')
    expected = 400.00
    actual = a.unit_price_to_dollars

    assert_equal expected, actual
  end

  def test_unit_price_to_dollars_correctly_converts_different_number_to_float
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "525", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => "56843166496526862"}, 'holder')
    expected = 5.25
    actual = a.unit_price_to_dollars

    assert_equal expected, actual
  end

  def test_unit_price_to_dollars_correctly_only_returns_2_decimal_points
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "525.964672", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => "56843166496526862"}, 'holder')
    expected = 5.26
    actual = a.unit_price_to_dollars

    assert_equal expected, actual
  end

  def test_unit_price_to_dollars_correctly_only_returns_2_decimal_points_again
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "1.23124565314865", :created_at => "2016-01-11 11:51:37 UTC", :updated_at => "2016-01-11 11:51:37 UTC", :merchant_id => "56843166496526862"}, 'holder')
    expected = 0.01
    actual = a.unit_price_to_dollars

    assert_equal expected, actual
  end
end

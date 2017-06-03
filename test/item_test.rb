require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require 'pry'


class ItemTest < Minitest::Test



  def test_it_exists
    a = Item.new({:name => "Mark", :id => nil, :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil}, ItemRepository)
    expected = Item
    actual = a

    assert_instance_of expected, actual
  end

  def test_it_shows_the_correct_name_when_passed_through
    a = Item.new({:name => "Mark", :id => nil, :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil}, ItemRepository)
    expected = "Mark"
    actual = a.name
    assert_equal expected, actual
  end

  def test_it_shows_the_correct_different_name_when_passed_through
    a = Item.new({:name => "Alice", :id => nil, :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil}, ItemRepository)
    expected = "Alice"
    actual = a.name

    assert_equal expected, actual
  end

  def test_it_shows_the_right_name_when_passed_through_again
    a = Item.new({:name => "Tyler", :id => nil, :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil}, ItemRepository)
    expected = "Tyler"
    actual = a.name
    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_through
    a = Item.new({:name => "Tyler", :id => "1234", :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil}, ItemRepository)
    expected = 1234
    actual = a.id

    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_through_again
    a = Item.new({:name => "Tyler", :id => "5280", :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil}, ItemRepository)
    expected = 5280
    actual = a.id

    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_a_million
    a = Item.new({:name => "Tyler", :id => "a million", :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil}, ItemRepository)
    expected = 0
    actual = a.id

    assert_equal expected, actual
  end

  def test_it_shows_the_right_information_passed_through_at_initialize
    a = Item.new({:name => "Tyler", :id => "a million", :description => "Monster Spray",
      :unit_price => "more than you can afford", :created_at => "now", :updated_at => "before", :merchant_id => "Prince smbol"}, ItemRepository)

    assert_equal "Tyler", a.name
    assert_equal 0, a.id
    assert_equal "Monster Spray", a.description
    assert_instance_of BigDecimal, a.unit_price
    assert_equal 0.0,  a.unit_price.to_f
    assert_equal "now", a.created_at
    assert_equal "before", a.updated_at
    assert_equal 0, a.merchant_id
  end

  def test_it_shows_the_right_information_passed_different_info
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "40,000", :created_at => "Monday", :updated_at => "Tuesday", :merchant_id => "56843166496526862"}, ItemRepository)

    assert_equal "Bruce", a.name
    assert_equal 685521578, a.id
    assert_equal "Not avaliable", a.description
    assert_instance_of BigDecimal, a.unit_price
    assert_equal 40.0, a.unit_price.to_f
    assert_equal 41.0, (a.unit_price + 1)
    assert_equal "Monday", a.created_at
    assert_equal "Tuesday", a.updated_at
    assert_equal 56843166496526862, a.merchant_id
  end

  def test_unit_price_to_dollars_correctly_converts_to_float
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "40000", :created_at => "Monday", :updated_at => "Tuesday", :merchant_id => "56843166496526862"}, ItemRepository)
    expected = 400.00
    actual = a.unit_price_to_dollars

    assert_equal expected, actual
  end

  def test_unit_price_to_dollars_correctly_converts_different_number_to_float
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "525", :created_at => "Monday", :updated_at => "Tuesday", :merchant_id => "56843166496526862"}, ItemRepository)
    expected = 5.25
    actual = a.unit_price_to_dollars

    assert_equal expected, actual
  end

  def test_unit_price_to_dollars_correctly_only_returns_2_decimal_points
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "525.964672", :created_at => "Monday", :updated_at => "Tuesday", :merchant_id => "56843166496526862"}, ItemRepository)
    expected = 5.26
    actual = a.unit_price_to_dollars

    assert_equal expected, actual
  end

  def test_unit_price_to_dollars_correctly_only_returns_2_decimal_points_again
    a = Item.new({:name => "Bruce", :id => "685521578", :description => "Not avaliable",
      :unit_price => "1.23124565314865", :created_at => "Monday", :updated_at => "Tuesday", :merchant_id => "56843166496526862"}, ItemRepository)
    expected = 0.01
    actual = a.unit_price_to_dollars

    assert_equal expected, actual
  end
end

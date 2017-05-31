require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require 'pry'


class ItemTest < Minitest::Test

  def test_it_exists
    a = Item.new({:name => "Mark", :id => nil, :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil})
    expected = Item
    actual = a

    assert_instance_of expected, actual
  end

  def test_it_shows_the_correct_name_when_passed_through
    a = Item.new({:name => "Mark", :id => nil, :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil})
    expected = "Mark"
    actual = a.name

    assert_equal expected, actual
  end

  def test_it_shows_the_correct_different_name_when_passed_through
    a = Item.new({:name => "Alice", :id => nil, :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil})
    expected = "Alice"
    actual = a.name

    assert_equal expected, actual
  end

  def test_it_shows_the_right_name_when_passed_through_again
    a = Item.new({:name => "Tyler", :id => nil, :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil})
    expected = "Tyler"
    actual = a.name

    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_through
    a = Item.new({:name => "Tyler", :id => "1234", :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil})
    expected = "1234"
    actual = a.id

    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_through_again
    a = Item.new({:name => "Tyler", :id => "5280", :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil})
    expected = "5280"
    actual = a.id

    assert_equal expected, actual
  end

  def test_it_shows_the_correct_id_when_passed_a_million
    a = Item.new({:name => "Tyler", :id => "a million", :description => nil,
      :unit_price => nil, :created_at => nil, :updated_at => nil, :merchant_id => nil})
    expected = "a million"
    actual = a.id

    assert_equal expected, actual
  end
end

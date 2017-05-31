require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/item_repository'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    a = ItemRepository.new('./data/items.csv')
    expected = ItemRepository
    actual = a

    assert_instance_of expected, actual
  end

  def test_it_reads_item_csv_and_returns_an_array_of_all
    a = ItemRepository.new('./data/items.csv')
    expected = 1367
    actual = a.all.length

    assert_equal expected, actual
  end

  def test_it_reads_item_csv_and_returns_a_class_Array
    a = ItemRepository.new('./data/items.csv')
    expected = Array
    actual = a.all.class

    assert_equal expected, actual
  end
end

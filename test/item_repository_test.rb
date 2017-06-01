require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/item_repository'
require_relative '../lib/item'
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

  def test_it_shows_changed_id_after_fnd_merch_id
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_merchant_id("12334185")
    actual = b[0].name
    # binding.pry
    expected = "Glitter scrabble frames"

    assert_equal expected, actual
    assert_equal 6, b.length
  end

  def test_it_shows_changed_id_after_find_merch_id
		a = ItemRepository.new('./data/items.csv')
		b = a.find_by_id("12337411")
		actual = b

		assert_nil actual
	end

  def test_it_finds_id
		a = ItemRepository.new('./data/items.csv')
		b = a.find_by_id("263395237")
		expected = 263395237
		actual = b.id

		assert_equal expected, actual
	end

  def test_it_shows_changed_id_after_find_item_id
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_id("263567376")
    expected = 263567376
    actual = b.id

    assert_equal expected, actual
  end

  def test_it_shows_id
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_id("263567242")
    expected = 263567242
    actual = b.id

    assert_equal expected, actual
  end

  def test_it_takes_names_in_normal_type
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_name("510+ RealPush Icon Set")
    actual = b.name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_takes_names_in_crazy_case
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_name("510+ ReAlPuSh IcOn SeT")
    actual = b.name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_takes_names_in_all_caps
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_name("510+ REALPUSH ICON SET")
    actual = b.name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_takes_names_in_all_low_case
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_name("510+ realpush icon set")
    actual = b.name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_searches_partial_description
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_with_description("soft drugs prejudices")
    actual = b[0].id if b[0] != nil
    expected = 263402475

    assert_equal expected, actual
  end

  def test_it_searches_partial_description_again
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_with_description("hard monster spray")
    actual = b[0].id if b[0] != nil

    assert_nil actual
  end

  def test_it_searches_partial_description_once_more
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_with_description("man on the moon")
    actual = b[0].id if b[0] != nil

    assert_nil actual
  end

  def test_it_searches_partial_description_once_again
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_with_description("successful beer brands worldwide")
    actual = b[0].id
    expected = 263451053

    assert_equal expected, actual
  end

  def test_it_searches_partial_description_if_you_can_believe_it
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_with_description("man on the moon")
    actual = b
    expected = []

    assert_equal expected, actual
  end

  def test_it_finds_all_by_price
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_by_price("1200")
    actual = b[0].unit_price
    expected = "1200"

    assert_equal expected, actual
  end

  def test_it_finds_all_by_price_zero
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_by_price("0")
    actual = b
    expected = []

    assert_equal expected, actual
  end

  def test_it_finds_all_by_price_2500
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_by_price("2500")
    actual = b[0].unit_price
    expected = "2500"

    assert_equal expected, actual
  end

  def test_it_finds_all_by_price_3000
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_by_price("3000")
    actual = b[0].name
    expected = "Moyenne toile"

    assert_equal expected, actual
  end

  def test_if_find_merchant_id
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_merchant_id("12334194")
    actual = b[0].name
    expected = "Boucles d&#39;oreilles en pâte polymère texturée - Argent 925/1000"
    other_expected = "Jolies boucles d&#39;oreilles en pâte polymère et cuir façonnées à la main"
    last_expected = "Belles boucles d&#39;oreilles géométriques très tendance en pâte polymère texturée."

    assert_equal other_expected, b[1].name
    assert_equal last_expected, b[2].name
    assert_equal 7, b.length
  end

  def test_if_find_merchant_id_returns_nil_array
    a = ItemRepository.new('./data/items.csv')
    b = a.find_by_merchant_id("1")
    actual = b
    expected = []

    assert_equal expected, actual
  end
  def test_it_finds_a_price_range
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_by_price_in_range(1199, 1201)
    actual = b[0].name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_finds_a_LARGE_price_range
    skip
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_by_price_in_range(2400000, 2600000)
    actual = b[0].name
    expected = "Original WWII Guinness Advertising Oil on Canvas Artwork by John Gilroy - 1944 Royal Navy Submarine Crew [ON8505]"

    assert_equal expected, actual
  end

  def test_it_finds_a_large_group_by_price
    a = ItemRepository.new('./data/items.csv')
    b = a.find_all_by_price_in_range(2000, 5000)
    first_name  = b[0].name
    second_name = b[1].name
    third_name  = b[2].name
    actual = [first_name, second_name, third_name]
    expected = ["Vogue Paris Original Givenchy 2307", "Wooden pen and stand", "HOT Crystal Dragon Fly Hand Blown Glass Art Gold Trim Figurine Lucky Collection"]

    assert_equal 427, b.length
    assert_equal expected, actual
  end
end

require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/item'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def setup
    ItemRepository.new('./test/data/items_fixture.csv', SalesEngine)
  end

  def test_it_exists
    a = setup
    expected = ItemRepository
    actual = a

    assert_instance_of expected, actual
  end

  def test_it_reads_item_csv_and_returns_an_array_of_all
    a = setup
    expected = 44
    actual = a.all.length

    assert_equal expected, actual
  end

  def test_it_reads_item_csv_and_returns_a_class_Array
    a = setup
    expected = Array
    actual = a.all.class

    assert_equal expected, actual
  end

  def test_it_shows_changed_id_after_fnd_merch_id
    a = setup
    b = a.find_all_by_merchant_id("12334185")
    actual = b[0].name
    # binding.pry
    expected = "Glitter scrabble frames"

    assert_equal expected, actual
    assert_equal 3, b.length
  end

  def test_it_shows_changed_id_after_find_merch_id
		a = setup
		b = a.find_by_id("12337411")
		actual = b

		assert_nil actual
	end

  def test_it_finds_id
		a = setup
		b = a.find_by_id("263395237")
		expected = 263395237
		actual = b.id

		assert_equal expected, actual
    assert_equal "510+ RealPush Icon Set", b.name
    assert_equal Item, b.class
	end

  def test_it_shows_changed_id_after_find_item_id
    a = setup
    b = a.find_by_id("263400793")
    expected = 263400793
    actual = b.id

    assert_equal expected, actual
  end

  def test_it_shows_id
    a = setup
    b = a.find_by_id("263401045")
    expected = 263401045
    actual = b.id

    assert_equal expected, actual
  end

  def test_it_takes_names_in_normal_type
    a = setup
    b = a.find_by_name("510+ RealPush Icon Set")
    actual = b.name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_takes_names_in_crazy_case
    a = setup
    b = a.find_by_name("510+ ReAlPuSh IcOn SeT")
    actual = b.name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_takes_names_in_all_caps
    a = setup
    b = a.find_by_name("510+ REALPUSH ICON SET")
    actual = b.name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_takes_names_in_all_low_case
    a = setup
    b = a.find_by_name("510+ realpush icon set")
    actual = b.name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_searches_partial_description
    a = setup
    b = a.find_all_with_description("ceramic bowl")
    actual = b[0].id if b[0] != nil
    expected = 263399037

    assert_equal expected, actual
  end

  def test_it_searches_partial_description_again
    a = setup
    b = a.find_all_with_description("hard monster spray")
    actual = b[0].id if b[0] != nil

    assert_nil actual
  end

  def test_it_searches_partial_description_once_more
    a = setup
    b = a.find_all_with_description("man on the moon")
    actual = b[0].id if b[0] != nil

    assert_nil actual
  end

  def test_it_searches_partial_description_once_again
    a = setup
    b = a.find_all_with_description("finished by hand.")
    actual = b[0].id
    expected = 263400329

    assert_equal expected, actual
  end

  def test_it_searches_partial_description_if_you_can_believe_it
    a = setup
    b = a.find_all_with_description("man on the moon")
    actual = b
    expected = []

    assert_equal expected, actual
  end

  def test_it_finds_all_by_price
    a = setup
    b = a.find_all_by_price("12.00")
    actual = b[0].unit_price_to_dollars
    expected = 12.0

    assert_equal expected, actual
  end

  def test_it_finds_all_by_price_zero
    a = setup
    b = a.find_all_by_price("0")
    actual = b
    expected = []

    assert_equal expected, actual
  end

  def test_it_finds_all_by_price_2500
    a = setup
    b = a.find_all_by_price("25")
    actual = b[0].unit_price_to_dollars
    expected = 25.0

    assert_equal expected, actual
  end

  def test_it_finds_all_by_price_3000
    a = setup
    b = a.find_all_by_price("30.0")
    actual = b[0].name
    expected = "Moyenne toile"

    assert_equal expected, actual
  end

  def test_if_find_merchant_id
    a = setup
    b = a.find_all_by_merchant_id("12334145")
    actual = b[0].name
    expected = "Green-turned Eucalyptus Bowl"
    # other_expected = "Jolies boucles d&#39;oreilles en pâte polymère et cuir façonnées à la main"
    # last_expected = "Belles boucles d&#39;oreilles géométriques très tendance en pâte polymère texturée."

    # assert_equal other_expected, b[1].name
    # assert_equal last_expected, b[2].name
    assert_equal 2, b.length
  end

  def test_if_find_merchant_id_returns_nil_array
    a = setup
    b = a.find_all_by_merchant_id("1")
    actual = b
    expected = []

    assert_equal expected, actual
  end

  def test_it_finds_a_price_range
    a = setup
    b = a.find_all_by_price_in_range(11.99..12.01)
    actual = b[0].name
    expected = "510+ RealPush Icon Set"

    assert_equal expected, actual
  end

  def test_it_finds_a_LARGE_price_range
    a = setup
    b = a.find_all_by_price_in_range(240.00..460.00)
    actual = b[0].name
    expected = "Course contre la montre"

    assert_equal expected, actual
  end

  def test_it_finds_a_large_group_by_price
    a = setup
    b = a.find_all_by_price_in_range(20.50..50.00)
    first_name  = b[0].name
    second_name = b[1].name
    third_name  = b[2].name
    actual = [first_name, second_name, third_name]
    expected = ["Vogue Paris Original Givenchy 2307", "Wooden pen and stand", "HOT Crystal Dragon Fly Hand Blown Glass Art Gold Trim Figurine Lucky Collection"]

    assert_equal 14, b.length
    assert_equal expected, actual
  end
end

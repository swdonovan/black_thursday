require 'minitest/autorun'
require 'minitest/emoji'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require 'pry'


class MerchantRepositoryTest < Minitest::Test

  def setup
    MerchantRepository.new('./data/merchants.csv', SalesEngine)
  end

  def test_it_exsists
    a = setup
    expected = MerchantRepository
    actual = a

    assert_instance_of expected, actual
  end

  def test_shows_correct_id
    a = setup
    expected = nil
    actual = a.id

    assert_nil actual
  end

  def test_shows_correct_name
    a = setup
    actual = a.name

    assert_nil actual
  end

  def test_it_shows_name
    a = setup
    b = a.find_by_name("CJsDecor")
    actual = b.name
    expected = "CJsDecor"

    assert_equal expected, actual
  end

  def test_it_returns_nil_when_name_wrong
    a = setup
    actual = a.find_by_name("Craigers")

    assert_nil actual
  end

  def test_it_shows_name_with_different_arguement
    a = setup
    b = a.find_by_name("GoldenRayPress")
    actual = b.name
    expected = "GoldenRayPress"

    assert_equal expected, actual
  end

  def test_it_shows_name_with_different_arguement_again
    a = setup
    b = a.find_by_name("Keckenbauer")
    actual = b.name
    expected = "Keckenbauer"

    assert_equal expected, actual
  end

  def test_it_takes_names_in_all_caps
    a = setup
    b = a.find_by_name("KECKENBAUER")
    actual = b.name
    expected = "Keckenbauer"

    assert_equal expected, actual
  end

  def test_it_takes_crazy_case
    a = setup
    b = a.find_by_name("KeCkEnBaUeR")
    actual = b.name
    expected = "Keckenbauer"

    assert_equal expected, actual
  end

  def test_it_takes_all_low_case
    a = setup
    b = a.find_by_name("keckenbauer")
    actual = b.name
    expected = "Keckenbauer"

    assert_equal expected, actual
  end

  def test_it_takes_one_up_case_at_end
    a = setup
    b = a.find_by_name("keckenbaueR")
    actual = b.name
    expected = "Keckenbauer"

    assert_equal expected, actual
  end

  def test_it_shows_name_one_more_time
    a = setup
    b = a.find_by_name("Shopin1901")
    actual = b.name
    expected = "Shopin1901"

    assert_equal expected, actual
  end

  def test_it_shows_changed_id_after_find_merch_id
    a = setup
    b = a.find_by_id("12337411")
    expected = 12337411
    actual = b.id

    assert_equal expected, actual
  end

  def test_it_shows_changed_id_after_find_merch_id_again
    a = setup
    b = a.find_by_id("12334159")
    expected = "SassyStrangeArt"
    actual = b.name

    assert_equal expected, actual
  end

  def test_all_shows_all_instances
    a = setup
    expected = 475
    actual = a.all.length

    assert_equal expected, actual
  end

  def test_if_find_all_by_name_selects_ltd
    a = setup
    array = a.find_all_by_name("ltd")
    actual = array.map do |merchant|
      merchant.name
    end
    expected = ["Promotionalsearchltd"]

    assert_equal expected, actual
    assert_equal Merchant, array[0].class
  end

  def test_if_find_all_by_name_selects_the
    a = setup
    array = a.find_all_by_name("the")
    actual = array.map do |merchant|
      merchant.name
    end
    expected = ["TheLilPinkBowtique", "thepurplepenshop", "TheHamAndRat", "TheAssemblyRooms", "matthewbritts", "TheWoodchopDesign", "ToThePoints", "TheKnitBySusie", "CANNATHERAPYCO", "TheSequinnedOwl", "TheLittleGlitter", "ForTheLoveOfCop", "LeatherMinn", "SeeyouSoonthen", "SweetheartDarling", "WhatTheDoctorOrdered", "StatesmanLeather", "NicholasLeatherWorld", "TheHairFader", "southernncreations", "Gracebythebook", "SouthernComfrtCndles", "TheCullenChronicles", "thesageandspirit"]

    assert_equal expected, actual
    assert_equal Merchant, array[0].class
  end

end

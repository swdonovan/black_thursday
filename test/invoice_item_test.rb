require_relative 'test_helper'
require_relative '../lib/invoice_item'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'


class InvoiceItemTest < Minitest::Test

  def setup
    @ii_1 = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4).to_s,
      :created_at => Time.now,
      :updated_at => Time.now
    }, self)

    @ii_2 = InvoiceItem.new({
      :id => 9,
      :item_id => 17,
      :invoice_id => 28,
      :quantity => 14,
      :unit_price => BigDecimal.new(14.99, 4).to_s,
      :created_at => Time.now,
      :updated_at => Time.now
    }, self)

    @ii_3 = InvoiceItem.new({
      :id => 16,
      :item_id => 72,
      :invoice_id => 48,
      :quantity => 15,
      :unit_price => BigDecimal.new(13.00, 3).to_s,
      :created_at => Time.now,
      :updated_at => Time.now
    }, self)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii_1
    assert_instance_of InvoiceItem, @ii_1
    assert_instance_of InvoiceItem, @ii_1
  end

  def test_ii_1
    assert_equal 6, @ii_1.id.to_i
    assert_equal 8, @ii_1.invoice_id.to_i
    assert_equal 7, @ii_1.item_id.to_i
    assert_equal 1, @ii_1.quantity.to_i
    assert_equal BigDecimal, @ii_1.unit_price.class
    assert_equal 0.1099, @ii_1.unit_price_to_dollars
    assert_equal Time, @ii_1.created_at.class
    assert_equal Time, @ii_1.created_at.class
  end

  def test_ii_2
    assert_equal 9, @ii_2.id.to_i
    assert_equal 28, @ii_2.invoice_id.to_i
    assert_equal 17, @ii_2.item_id.to_i
    assert_equal 14, @ii_2.quantity.to_i
    assert_equal BigDecimal, @ii_2.unit_price.class
    assert_equal 0.1499, @ii_2.unit_price_to_dollars
    assert_equal Time, @ii_2.created_at.class
    assert_equal Time, @ii_2.created_at.class
  end

  def test_ii_3
    assert_equal 16, @ii_3.id.to_i
    assert_equal 48, @ii_3.invoice_id.to_i
    assert_equal 72, @ii_3.item_id.to_i
    assert_equal 15, @ii_3.quantity.to_i
    assert_equal BigDecimal, @ii_3.unit_price.class
    assert_equal 0.13, @ii_3.unit_price_to_dollars
    assert_equal Time, @ii_3.created_at.class
    assert_equal Time, @ii_3.created_at.class
  end
end

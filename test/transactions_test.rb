require_relative 'test_helper'
require_relative '../lib/transaction'
require 'time'

class TransactionTest < Minitest::Test

  def setup
    @t_1 = Transaction.new({
  :id => 6,
  :invoice_id => 8,
  :credit_card_number => "4242424242424242",
  :credit_card_expiration_date => "0220",
  :result => "success",
  :created_at => Time.now,
  :updated_at => Time.now
}, self)

    @t_2 = Transaction.new({
  :id => 9,
  :invoice_id => 15,
  :credit_card_number => "5489377869874628",
  :credit_card_expiration_date => "4598",
  :result => "failed",
  :created_at => Time.now,
  :updated_at => Time.now
}, self)

    @t_3 = Transaction.new({
  :id => 18,
  :invoice_id => 2,
  :credit_card_number => "3698753215987642",
  :credit_card_expiration_date => "1465",
  :result => "not sure",
  :created_at => Time.now,
  :updated_at => Time.now
}, self)
  end

  def test_it_exists
    assert_instance_of Transaction, @t_1
    assert_instance_of Transaction, @t_2
    assert_instance_of Transaction, @t_3
  end

  def test_t_1
    assert_equal 6, @t_1.id.to_i
    assert_equal 8, @t_1.invoice_id.to_i
    assert_equal "4242424242424242", @t_1.credit_card_number
    assert_equal "0220", @t_1.credit_card_expiration_date
    assert_equal "success", @t_1.result
    assert_equal Time, @t_1.created_at.class
    assert_equal Time, @t_1.updated_at.class
  end

  def test_t_2
    assert_equal 9, @t_2.id.to_i
    assert_equal 15, @t_2.invoice_id.to_i
    assert_equal "5489377869874628", @t_2.credit_card_number
    assert_equal "4598", @t_2.credit_card_expiration_date
    assert_equal "failed", @t_2.result
    assert_equal Time, @t_2.created_at.class
    assert_equal Time, @t_2.updated_at.class
  end

  def test_t_3
    assert_equal 18, @t_3.id.to_i
    assert_equal 2, @t_3.invoice_id.to_i
    assert_equal "3698753215987642", @t_3.credit_card_number
    assert_equal "1465", @t_3.credit_card_expiration_date
    assert_equal "not sure", @t_3.result
    assert_equal Time, @t_3.updated_at.class
    assert_equal Time, @t_3.created_at.class
  end
end

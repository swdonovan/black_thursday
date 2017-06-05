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
        :id => 12,
        :invoice_id => 81,
        :credit_card_number => "1234567898765432",
        :credit_card_expiration_date => "5280",
        :result => "failure",
        :created_at => Time.now,
        :updated_at => Time.now
      }, self)

      @t_3 = Transaction.new({
        :id => 67,
        :invoice_id => 4,
        :credit_card_number => "1212121212121212",
        :credit_card_expiration_date => "8008",
        :result => "tbd",
        :created_at => Time.now,
        :updated_at => Time.now
      }, self)
    end

    def test_it_exists
      assert_instance_of Transaction, @t_1
      assert_instance_of Transaction, @t_1
      assert_instance_of Transaction, @t_1
    end

    def test_ii_1
      assert_equal 6, @t_1.id
      assert_equal 8, @t_1.invoice_id
      assert_equal "4242424242424242", @t_1.credit_card_number.to_s
      assert_equal "0220", @t_1.credit_card_expiration_date
      assert_equal "success", @t_1.result
      assert_equal Time, @t_1.created_at.class
      assert_equal Time, @t_1.updated_at.class
    end

    def test_ii_2
      assert_equal 12, @t_2.id
      assert_equal 81, @t_2.invoice_id
      assert_equal "1234567898765432", @t_2.credit_card_number.to_s
      assert_equal "5280", @t_2.credit_card_expiration_date
      assert_equal "failure", @t_2.result
      assert_equal Time, @t_2.created_at.class
      assert_equal Time, @t_2.updated_at.class
    end

    def test_ii_3
      assert_equal 67, @t_3.id
      assert_equal 4, @t_3.invoice_id
      assert_equal "1212121212121212", @t_3.credit_card_number.to_s
      assert_equal "8008", @t_3.credit_card_expiration_date
      assert_equal "tbd", @t_3.result
      assert_equal Time, @t_3.created_at.class
      assert_equal Time, @t_3.updated_at.class
    end

end

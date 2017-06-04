require 'time'
require_relative 'test_helper'
require_relative '../lib/invoice'


class InvoiceTest < Minitest::Test

  def setup
		@i_1 = Invoice.new({
	  :id          => 1,
	  :customer_id => 2,
	  :merchant_id => 3,
	  :status      => "paid",
	  :created_at  => Time.now.to_s,
	  :updated_at  => Time.now.to_s,
		}, self)

		@i_2 = Invoice.new({
			:id          => 6,
			:customer_id => 7,
			:merchant_id => 8,
			:status      => "pending",
			:created_at  => Time.now.to_s,
			:updated_at  => Time.now.to_s,
			}, self)

		@i_3 = Invoice.new({
			:id          => 5,
			:customer_id => 20,
			:merchant_id => 85,
			:status      => "shipped",
			:created_at  => Time.now.to_s,
			:updated_at  => Time.now.to_s,
			}, self)
  end

	def test_everything_in_the_world
		assert_instance_of Invoice, @i_1
		assert_equal 1, @i_1.id
		assert_equal :paid, @i_1.status
		assert_instance_of Time, @i_3.created_at
		assert_equal 85, @i_3.merchant_id
		assert_equal :pending, @i_2.status
		assert_equal 7, @i_2.customer_id
		assert_instance_of Time, @i_3.updated_at
	end



end

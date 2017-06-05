require 'pry'
require 'csv'
require 'time'


class Invoice
	attr_reader :customer_id,
							:id,
							:merchant_id,
							:status,
							:created_at,
							:updated_at,
							:inv

	def initialize(item_info, inv)
		@inv         = inv
		@customer_id = item_info[:customer_id].to_i
		@id          = item_info[:id].to_i
		@merchant_id = item_info[:merchant_id].to_i
		@status      = item_info[:status].intern
		@created_at  = Time.parse(item_info[:created_at])
		@updated_at  = Time.parse(item_info[:updated_at])
	end

	def merchant
		inv.pass_to_se_merchant(merchant_id)
	end

	def items
		inv.get_items_from_se(id)
	end

	def transactions
		inv.get_transactions_from_se(id)
	end

	def customer
		inv.get_customer_from_se(customer_id)
	end

	def is_paid_in_full?
		payment_status = transactions
		if payment_status.all? { |e| e.result == "success"}
			true
		elsif payment_status == nil
			false
		else
			false
		end
	end

	def total
	end
end

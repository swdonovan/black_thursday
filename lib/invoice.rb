require 'pry'
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
		@status      = item_info[:status].to_s
		@created_at  = item_info[:created_at]
		@updated_at  = item_info[:updated_at]
	end
end

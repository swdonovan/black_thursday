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
		if payment_status == []
		  false
	  elsif payment_status.all? { |e| e.result == "success"}
			true
		else
			false
		end
	end

	def total
		to_calc = get_invoice_items(find_successful_transactions)
		find_total_unit_cost(to_calc).uniq.shift
	end

	def find_successful_transactions
		transactions.each do |unpaid|
			transactions.delete(unpaid) if unpaid.result == "failed"
		end
	end

	def get_invoice_items(list)
		all_items = []
    list.map do |transaction|
		  all_items << (inv.get_invoice_items_from_se(transaction.invoice_id))
		end
		all_items
	end

	def find_total_unit_cost(list)
		list.map! do |inv_item_group|
			transactionception_level_1(inv_item_group)
    end
	end

	def transactionception_level_1(array)
		array.inject(0) {|sum, paid| sum + (paid.unit_price * paid.quantity)}
	end

	def total_quantity
		to_calc = get_invoice_items(find_successful_transactions)
		to_calc = to_calc.flatten
		find_total_invoice_quantity(to_calc)
	end

	# def find_total_invoice_quantity(list)
	# 	list.map! do |inv_item_group|
	# 		binding.pry
	# 		transactionception_level_2(inv_item_group)
	# 	end
	# end

	def find_total_invoice_quantity(list)
		list.inject(0) do |sum, paid|
			sum + (paid.quantity)
		end
	end
end

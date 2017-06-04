require 'pry'
require 'csv'
require_relative 'invoice'

class InvoiceRepository

	attr_reader :contents,
              :all,
              :se

  def initialize(item_info, se)
    @se = se
		@contents = CSV.open item_info, headers: true, header_converters: :symbol
    read_lines
	end

	# def inspect
		# "#<#{self.class} #{@invoices.size} rows>"
	# end

	def read_lines
		@all = @contents.map do |row|
			Invoice.new({:customer_id => row[1], :id => row[0], :merchant_id => row[2],
				:status => row[3], :updated_at => row[5], :created_at => row[4]}, self)
		end
		return all
	end

	def find_by_id(id)
		invoice = all.select do |instance|
			instance if instance.id == id
		end
		return invoice.shift
	end

	def find_all_by_customer_id(customer_id)
		customer = all.select do |instance|
			instance if instance.customer_id == customer_id
		end
		return customer
	end

	def find_all_by_merchant_id(merchant_id)
		merchant = all.select do |instance|
			instance if instance.merchant_id == merchant_id
		end
		return merchant
	end

	def find_all_by_status(status)
		status = all.select do |instance|
			instance if instance.status == status
		end
		return status
	end

	def pass_to_se_merchant(merchant_id)
		se.find_merchant_by_item_id(merchant_id)
	end

end
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'
#
class SalesEngine
	attr_reader :merchants,
							:items,
							:invoices

	def initialize(argv_values)
		@merchants = MerchantRepository.new(argv_values[:merchants], self)
		@items = ItemRepository.new(argv_values[:items], self)
		@invoices = InvoiceRepository.new(argv_values[:invoices], self)
	end

	def self.from_csv(argv_values)
		SalesEngine.new(argv_values)
	end

	def find_items_by_merchant_id(id)
		items.find_all_by_merchant_id(id)
	end

	def find_merchant_by_item_id(id)
    merchants.find_by_id(id)
	end
end

# se = SalesEngine.from_csv({
# 	:items     => ARGV[0],
# 	:merchants => ARGV[1],
# })
#
# merchant = se.merchants.all
# item = se.items.all

# def find_average(merchant)
# 	top = setup_average(merchant).inject(0) {|sum, instance| sum + instance.length}
# 	bottom = setup_average(merchant).length
# 	average = top.to_f / bottom.to_f
# 	average.round(2)
# end
#
# def setup_average(merchant)
# 	all_merchants = []
# 		merchant.map do |merch|
# 			all_merchants << merch.items
# 		end
# 	all_merchants
# end

# puts "the average number of items per merchant is #{find_average(merchant)}"

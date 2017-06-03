require_relative 'sales_engine'
require 'pry'

class SalesAnalyst
		attr_reader :se

	def initialize (se = SalesEngine)
		@se = se
	end

	def average_items_per_merchant
		all_merchants = se.merchants.all
		find_average(all_merchants)
	end

	def find_average(all_merchants)
		numerator = setup_average(all_merchants).inject(0) do |sum, instance|
			sum + instance.length
		end
		denominator = setup_average(all_merchants).length
		average = numerator.to_f / denominator.to_f
		average.round(2)
	end

	def setup_average(all_merchants)
		merchants = []
		all_merchants.map do |merch|
			merchants << merch.items
		end
		merchants
	end

	def average_items_per_merchant_standard_deviation
		all_merchants = se.merchants.all
		average = find_average(all_merchants)
		setup = setup_average(all_merchants)
		standard_deviation = standard_deviation_computation(setup, average)

	end

	def standard_deviation_computation(setup, average)
		st_dev = setup.inject(0) do |sum, instance|
			sum + ((instance.length - average)**2)
		end
		st_dev = Math.sqrt(st_dev / (setup.length - 1))
		st_dev.round(2)
	end

	def merchants_with_high_item_count
		st_d = average_items_per_merchant_standard_deviation
		all_merchants = se.merchants.all
		setup = setup_average_instance(all_merchants)
		find_high_item_merchants(st_d, setup)
	end

	def find_high_item_merchants(st_d, setup)
		merchants = []
		setup.select do |merchant|
			merchants << merchant.name if merchant.items.length >= st_d
		end
		merchants
	end

	def setup_average_instance(all_merchants)
		merchants = []
		all_merchants.map do |merch|
			merchants << merch
		end
		merchants
	end

	def average_item_price_for_merchant(id)
		returned_merchant = se.merchants.find_by_id(id)
		list_of_items = returned_merchant.items
		average_item_price = (find_numerator(list_of_items)) / (find_denominator(list_of_items))
	end

	def find_numerator(items)
		items.inject(0) {|sum, price| sum + price.unit_price}
	end

	def find_denominator(items)
		items.length
	end
end

# se = SalesEngine.from_csv({
#   :items     => ARGV[0],
#   :merchants => ARGV[1],
# })
#
# sa = SalesAnalyst.new(se)
#

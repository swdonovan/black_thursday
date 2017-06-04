require_relative 'sales_engine'
require 'pry'
require 'date'
require 'time'

class SalesAnalyst
		attr_reader :se

	def initialize(se)
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
		average = numerator.to_f / find_denominator(setup_average(all_merchants)).to_f
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
		# setup = setup_average_instance(all_merchants)
		find_high_item_merchants(st_d, all_merchants, find_average(all_merchants))
	end

	def find_high_item_merchants(st_d, setup, average)
		merchants = []
		setup.select do |merchant|
			merchants << merchant if merchant.items.length >= (st_d + average)
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
		average_item_price.round(2)
	end

	def find_numerator(items)
		items.inject(0) {|sum, item| sum + item.unit_price}
	end

	def find_denominator(items)
		if items.length == 0
			return 1
		else items.length
		end
	end

	def average_average_price_per_merchant
    all_merchants = se.merchants.all
		total = find_all_average_prices(all_merchants) / find_denominator(all_merchants)
		total.round(2)
	end

	def find_all_average_prices(merchants)
		merchants.inject(0) do |sum, merch|
			sum + average_item_price_for_merchant(merch.id)
		end
	end

	def golden_items
		all_items = se.items.all
		average = find_average_price(all_items)
		st_d = average_price_per_item_standard_deviation(average, all_items)
		find_golden_items(st_d, all_items, average)
	end

	def average_price_per_item_standard_deviation(average, all_items)
		standard_deviation_price_computation(all_items, average)
	end

	def standard_deviation_price_computation(setup, average)
		st_dev = setup.inject(0) do |sum, instance|
			sum + ((instance.unit_price_to_dollars - average)**2)
		end
		st_dev = Math.sqrt(st_dev / (setup.length - 1))
		st_dev.round(2)
	end

	def find_average_price(all_items)
		average = find_price_numerator(all_items).to_f / find_denominator(all_items).to_f
		average.round(2)
	end

	def find_price_numerator(items)
		items.inject(0) {|sum, item| sum + item.unit_price_to_dollars}
	end

	def find_golden_items(st_d, setup, average)
		golden_items = []
		setup.select do |item|
			golden_items << item if item.unit_price_to_dollars > (((st_d - average) * 2) + average)
		end
		golden_items
	end

	def average_invoices_per_merchant
		merchants = se.merchants.all
		invoices = se.invoices.all
		average = average(invoices.length, merchants.length)
		average.round(2)
	end

	def average_invoices_per_merchant_standard_deviation
		average = average_invoices_per_merchant
		setup = merch_invoice_instance
		standard_deviation_computation(setup, average)
	end

	def merch_invoice_instance
		all_merchants = se.merchants.all
		all_merchants = all_merchants.map do |merchant|
			merchant.invoices
		end
		all_merchants
	end

	def top_merchants_by_invoice_count
		std_dev = average_invoices_per_merchant_standard_deviation
		average = average_invoices_per_merchant
		top_count = []
		se.merchants.all.select do |merchant|
			if merchant.invoices.length >= (average.to_f + (std_dev*2))
				top_count << merchant
			end
		end
		top_count
	end

	def bottom_merchants_by_invoice_count
		std_dev = average_invoices_per_merchant_standard_deviation
		average = average_invoices_per_merchant
		bottom_count = []
		se.merchants.all.select do |merchant|
			if merchant.invoices.length <= (average.to_f - (std_dev * 2))
				bottom_count << merchant
			end
		end
		bottom_count
	end


	def top_days_by_invoice_count
		grouped_inv = date_group_invoices
		std_dev = days_of_the_week_standard_deviation(grouped_inv)
		days = days_above_two_stdevs(grouped_inv, std_dev)
	end

	def date_group_invoices
		by_day_inv = se.invoices.all.group_by do |invoice|
			created_on(invoice.created_at)
		end
	end

	def created_on(invoice_date)
		invoice_date.strftime("%A")
	end

	def days_of_the_week_standard_deviation(grouped_inv)
		average = days_of_the_week_average(grouped_inv)
		st_dev = grouped_inv.keys.inject(0) do |sum, day|
			sum + (((grouped_inv[day].length) - average)**2)
		end
		st_dev = Math.sqrt(st_dev / (grouped_inv.length - 1))
		st_dev.round(2)
	end

	def days_of_the_week_average(grouped_inv)
		sum = grouped_inv.keys.inject(0) do |sum, date|
  		sum + grouped_inv[date].length
		end
		average = sum.to_f / grouped_inv.length.to_f
	end

	def days_above_two_stdevs(grouped_inv, std)
		average = days_of_the_week_average(grouped_inv)
		day = []
		grouped_inv.keys.find_all do |days|
			day << days if grouped_inv[days].length > (average + std)
		end
		day
	end

	def average(numerator, denominator)
		numerator.to_f / denominator.to_f
	end

	def invoice_status(status)
		status = status
		desired_status = se.invoices.find_all_by_status(status).length.to_f
		all_status = se.invoices.all.length.to_f
		percentage = ((desired_status / all_status) * 100)
		percentage.round(2)
	end

end
# se = SalesEngine.from_csv({
#   :items     => ARGV[0],
#   :merchants => ARGV[1],
# })
#
# sa = SalesAnalyst.new(se)
#

require_relative 'sales_engine'
require 'pry'

class SalesAnalyst
		attr_reader :se

	def initialize (se = SalesEngine)
		@se = se
	end

	def average_items_per_merchant
		all_merchants = se.merchants
binding.pry
	end

end

# se = SalesEngine.from_csv({
#   :items     => ARGV[0],
#   :merchants => ARGV[1],
# })
#
# sa = SalesAnalyst.new(se)
#

require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'
#
class SalesEngine
	attr_reader :merchants,
							:items

	def initialize(argv_values)
		@merchants = MerchantRepository.new(argv_values[:merchants])
		@items = ItemRepository.new(argv_values[:items])
	end

	def self.from_csv(argv_values)
		SalesEngine.new(argv_values)
	end

end

# se = SalesEngine.from_csv({
#   :items     => ARGV[0],
#   :merchants => ARGV[1],
# })

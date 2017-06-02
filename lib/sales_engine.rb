require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'
#
class SalesEngine
	attr_reader :merchants,
							:items

	def initialize(argv_values)
		@merchants = MerchantRepository.new(argv_values[:merchants], self)
		@items = ItemRepository.new(argv_values[:items], self)
	end

	def self.from_csv(argv_values)
		SalesEngine.new(argv_values)
	end

	def find_items_by_merchant_id(id)
		@items.find_all_by_merchant_id(id)
	end

	def find_merchant_by_item_id(id)
    @merchants.find_by_id(id)
	end
end

se = SalesEngine.from_csv({
  :items     => ARGV[0],
  :merchants => ARGV[1],
})

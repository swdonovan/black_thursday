require_relative 'merchant_repository'
require 'pry'

class SalesEngine

	def self.from_csv(argv_values)
		@merchants = argv_values[:merchants]
		@items = argv_values[:items]
	end

	def merchants
		binding.pry
		MerchantRepository.new(@merchants)
	end
end

# se = SalesEngine.from_csv({
#   :items     => ARGV[0],
#   :merchants => ARGV[1],
# })

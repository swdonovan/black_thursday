require 'csv'
require_relative 'merchant_repository'


class Merchant
	attr_reader :name,
							:id

	def initialize(merch_info, mr = MerchantRepository)
		@name = merch_info[:name]
		@id   = merch_info[:id].to_i
		@mr   = mr
	end

	def items
    @mr.pass_to_se(id)
	end
end

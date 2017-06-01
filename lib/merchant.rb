require 'csv'


class Merchant
	attr_reader :name,
							:id

	def initialize(merch_info)
		@name = merch_info[:name]
		@id   = merch_info[:id].to_i
	end
end

require 'csv'

class Merchant
	attr_reader :name,
							:id,
							:mr

	def initialize(merch_info, mr)
		@mr   = mr
		@name = merch_info[:name]
		@id   = merch_info[:id].to_i
	end

	def items
    mr.pass_to_se(id)
	end
end

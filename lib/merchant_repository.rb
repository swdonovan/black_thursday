require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository
	attr_reader :name,
							:id,
							:contents

	def initialize(merchant_info)
		@id = id
		@name = name

		@contents = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
		@empty = []
		read_lines
	end

	def read_lines
		@contents.each do |row|
			@empty << Merchant.new({:id => row[0], :name => row[1]})
		end
		binding.pry
		return empty
	end

	# def find_merchant_id
	# 	contents.each do |row|
	# 		@id = row
	# 	end
	# end
	#
	# def find_merchant_name
	# 	contents.each do |row|
	# 		@name = row[1]
	# 	end
	# end

end

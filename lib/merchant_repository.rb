require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository
	attr_reader :name,
							:id,
							:contents,
							:empty

	def initialize(merchant_info)
		@id = id
		@name = name

		@contents = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
		read_lines
	end

	def read_lines
		@empty = @contents.map do |row|
			Merchant.new({:id => row[0], :name => row[1]})
		end
		return @empty
	end

	def find_by_name(name)
		name = name.to_s
		@empty.map do |word|
			# binding.pry
			if name == word.name
				return word
			end
		end
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

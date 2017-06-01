require 'pry'
require 'csv'
require_relative 'merchant'
# For initial setup commit

class MerchantRepository
	attr_reader :name,
							:id,
							:contents,
							:all

	def initialize(merchant_info)
		open_file(merchant_info)
		read_lines
	end

	def open_file(merchant_info)
		@contents = CSV.open merchant_info, headers: true, header_converters: :symbol
	end

	def read_lines
		@all = @contents.map do |row|
			Merchant.new({:id => row[0], :name => row[1]})
		end
		return @all
	end

	def find_by_name(name)
		name = name.to_s.upcase
		merchant = nil
		@all.map do |word|
		 merchant = word if name == word.name.upcase
		end
		return merchant
	end

	def find_by_id(id)
		id = id.to_s
		merchant = nil
		@all.map do |word|
		 merchant = word if id == word.id
		end
		return merchant
	end

	def find_all_by_name(segment)
		choices = @all.select do |merchant|
			merchant.name.upcase.include?(segment.upcase)
		end
		choices.map do |line|
			line.name.to_s
		end
	end
end

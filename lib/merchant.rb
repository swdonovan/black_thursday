require 'pry'
require 'csv'


class Merchant
	attr_reader :name,
							:id,
							:contents

  def initialize(merchant_info)
    @id = id
    @name = name
		
    @contents = CSV.open './data/merchants.csv' #headers: true, header_converters: :symbol
  end

  def find_merchant_id
    contents.each do |row|
      @id = row[0]
    end
  end

  def find_merchant_name
    contents.each do |row|
      @name = row[1]
    end
  end
end

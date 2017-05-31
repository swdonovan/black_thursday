require 'pry'
require 'csv'
require_relative 'item'

class ItemRepository

  attr_reader :contents, :all

  def initialize(item_info)
		@contents = CSV.open item_info, headers: true, header_converters: :symbol
    read_lines
	end

  def read_lines
    @all = @contents.map do |row|
      Item.new({:name => row[1], :id => row[0], :description => row[2],
        :unit_price => row[3], :created_at => row[5], :updated_at => row[6], :merchant_id => row[4]})
    end
    return @all
  end

end

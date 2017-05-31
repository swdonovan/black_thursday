require 'pry'
require 'csv'
require_relative 'item'

class ItemRepository

  attr_reader :contents,
              :all

  def initialize(item_info)
		@contents = CSV.open item_info, headers: true, header_converters: :symbol
    read_lines
	end

  def read_lines
    @all = @contents.map do |row|
      Item.new({:name => row[1], :id => row[0], :description => row[2],
        :unit_price => row[3], :created_at => row[5], :updated_at => row[6], :merchant_id => row[4]})
    end
    return all
  end

  def find_by_id(id)
		id = id.to_s
		item = nil
		all.map do |word|
		 item = word if id == word.id
		end
		return item
	end

  def find_by_name(name)
    name = name.to_s.upcase
    item = nil
    all.map do |word|
      item = word if name == word.name.upcase
    end
    return item
  end

  def find_all_with_description(segment)
		choices = all.select do |item|
			item.description.upcase.include?(segment.upcase)
		end
	end

  def find_all_by_price(amount)
    choices = @all.select do |price|
			price.unit_price == amount
    end
    choices
  end

  def find_by_merchant_id(merchant_id)
		merchant_id = merchant_id.to_s
		item = nil
		@all.map do |name|
		  item = name if merchant_id == name.merchant_id
		end
		return item
	end

end

require 'pry'
require 'csv'
require_relative 'item'

class ItemRepository

  attr_reader :contents,
              :all,
              :se

  def initialize(item_info, se  )
    @se = se
		@contents = CSV.open item_info, headers: true, header_converters: :symbol
    read_lines
	end

  def read_lines
    @all = @contents.map do |row|
      Item.new({:name => row[1], :id => row[0], :description => row[2],
        :unit_price => row[3], :created_at => row[5], :updated_at => row[6], :merchant_id => row[4]}, self)
    end
    return all
  end

  def find_by_id(id)
		id = id.to_i
		item = nil
		all.map do |instance|
		 item = instance if id == instance.id
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
		@all.select do |item|
			item.description.upcase.include?(segment.upcase)
		end
	end

  def find_all_by_price(amount)
    @all.select do |price|
			price.unit_price == amount
    end
  end

  def find_all_by_merchant_id(merchant_id)
		all.find_all do |item|
		  item.merchant_id == merchant_id.to_i
		end
	end

  def find_all_by_price_in_range(range)
    range = convert_range(range)
    choices = all.select do |price|
      range.include?(price.unit_price.to_i)
    end
  end

  def convert_range(range)
    range = range.to_s.split("..")
    range = [*((range[0].to_f)*100).to_i..((range[1].to_f)*100).to_i]
  end

  def pass_to_se(id)
    se.find_merchant_by_item_id(id)
  end
end

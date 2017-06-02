require 'pry'
require 'csv'
require_relative 'item'
require_relative 'sales_engine'

class ItemRepository

  attr_reader :contents,
              :all

  def initialize(item_info, se = SalesEngine)
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
		# merchant_id = merchant_id.to_i
		# item = []
		all.find_all do |item|
		  item.merchant_id == merchant_id.to_i
		end
		# return item
	end

  def find_all_by_price_in_range(start_range, end_range)
    range = [*(start_range.to_s)..(end_range.to_s)]
    choices = all.select do |price|
      range.include?(price.unit_price)
    end
    choices.map do |line|
      line
    end
  end

  def pass_to_se(id)
    @se.find_merchant_by_item_id(id)
  end
end

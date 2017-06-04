require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'


class Item

  attr_reader :name,
              :id,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :ir

  def initialize(item_info, ir)
    @ir          = ir
    @name        = item_info[:name]
    @id          = item_info[:id].to_i
    @description = item_info[:description]
    @unit_price  = ((to_big_decimal(item_info[:unit_price]))/ 100) unless item_info[:unit_price] == nil
    @created_at  = Time.parse(item_info[:created_at])
    @updated_at  = Time.parse(item_info[:updated_at])
    @merchant_id = item_info[:merchant_id].to_i
  end

  def to_big_decimal(price)
    price = BigDecimal.new(price, price.length)

  end

  def unit_price_to_dollars
    dollar_amount = ((@unit_price.to_f))
    dollar_amount.round(2)
  end

  def merchant
    ir.pass_to_se(merchant_id)
  end

  # def saomething
  #   @ir.
end

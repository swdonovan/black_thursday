require 'csv'

class Item

  attr_reader :name,
              :id,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item_info)
    @name        = item_info[:name]
    @id          = item_info[:id]
    @description = item_info[:merchant_id]
    @unit_price  = item_info[:merchant_id]
    @created_at  = item_info[:merchant_id]
    @updated_at  = item_info[:merchant_id]
    @merchant_id = item_info[:merchant_id]
  end
end

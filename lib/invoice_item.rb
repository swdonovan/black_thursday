require 'csv'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :ii

  def initialize(invoice_item_info, ii)
    @ii         = ii
    @id         = invoice_item_info[:id]
    @item_id    = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id]
    @quantity   = invoice_item_info[:quantity]
    @created_at = invoice_item_info[:created_at]
    @updated_at = invoice_item_info[:updated_at]
    @unit_price = invoice_item_info[:unit_price]
  end

  # def to_big_decimal(price)
  #   price = BigDecimal.new(price, price.length)
  # end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end

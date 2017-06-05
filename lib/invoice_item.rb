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
    @id         = invoice_item_info[:id].to_i
    @item_id    = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @quantity   = invoice_item_info[:quantity].to_i
    @created_at = Time.parse(invoice_item_info[:created_at].to_s)
    @updated_at = Time.parse(invoice_item_info[:updated_at].to_s)
    @unit_price = ((to_big_decimal(invoice_item_info[:unit_price]))/ 100) unless invoice_item_info[:unit_price] == nil
  end

  def to_big_decimal(price)
    price = BigDecimal.new(price, price.length)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end

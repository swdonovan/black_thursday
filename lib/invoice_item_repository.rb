require 'csv'
require_relative 'invoice_item'
require 'time'

class InvoiceItemRepository
  attr_reader :contents,
  :all,
  :se

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def initialize(invoice_item_info, se)
    @se = se
    @contents = CSV.open invoice_item_info, headers: true, header_converters: :symbol
    read_lines
  end

  def read_lines
    @all = @contents.map do |row|
      InvoiceItem.new({:item_id => row[1], :id => row[0], :invoice_id => row[2],
        :quantity => row[3], :created_at => row[5], :updated_at => row[6], :unit_price => row[4]}, self)
    end
    return all
  end

  def find_by_id(id)
    invoice = all.select do |instance|
      instance if instance.id == id
    end
    return invoice.shift
  end

  def find_all_by_item_id(item_id)
    item = all.select do |instance|
      instance if instance.item_id == item_id
    end
    return item
  end

  def find_all_by_invoice_id(invoice_id)
    invoice = all.select do |instance|
      instance if instance.invoice_id == invoice_id
    end
    return invoice
  end

  def find_all_items_by_invoice_id(id)
    items = (find_all_by_invoice_id(id)).map do |inv_item|
      se.items.find_by_id(inv_item.item_id)
    end
    items
  end
end

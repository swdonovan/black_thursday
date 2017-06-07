require 'csv'
require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :cst

  def initialize(customer_info, cst)
    @cst                 = cst
    @id                  = customer_info[:id].to_i
    @created_at          = Time.parse(customer_info[:created_at].to_s)
    @updated_at          = Time.parse(customer_info[:updated_at].to_s)
    @first_name          = customer_info[:first_name]
    @last_name           = customer_info[:last_name]
  end

  def merchants
    cst.get_merchants_from_se(id)
  end

  def invoices
    cst.get_invoices_for_customer_id(id)
  end

  def invoice_items
    invoice_ids = invoices
    invoice_ids.map! do |invoice|
      invoice.id
    end
    invoice_ids.map do |id|
      cst.get_invoice_items_from_se(id)
    end
  end
end

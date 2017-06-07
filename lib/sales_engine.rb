require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'csv'
require 'pry'
#
class SalesEngine
  attr_reader :merchants,
  :items,
  :invoices,
  :invoice_items,
  :transactions,
  :customers

  def initialize(argv_values)
    @merchants      = MerchantRepository.new(argv_values[:merchants], self)
    @items          = ItemRepository.new(argv_values[:items], self)
    @invoices       = InvoiceRepository.new(argv_values[:invoices], self)
    @invoice_items  = InvoiceItemRepository.new(argv_values[:invoice_items], self)
    @transactions   = TransactionRepository.new(argv_values[:transactions], self)
    @customers      = CustomerRepository.new(argv_values[:customers], self)
  end

  def self.from_csv(argv_values)
    SalesEngine.new(argv_values)
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_item_id(id)
    merchants.find_by_id(id)
  end

  def find_invoice_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id)
  end

  def find_items_by_invoice_id_1(id)
    invoice_items.find_all_items_by_invoice_id(id)
  end

  def find_items_by_invoice_id_2(id)
    items.find_by_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transactions.find_all_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    customers.find_by_id(id)
  end

  def find_invoice_by_invoice_id(id)
    invoices.find_by_id(id)
  end

  def find_customers_by_merchant_id(id)
    merch_invoices = invoices.find_all_by_merchant_id(id)
    customers = []
    merch_invoices.map do |invoice|
      customers << invoice.customer
    end
    customers
  end

  def find_merchants_by_customer_id(id)
    list_of_invoices = invoices.find_all_by_customer_id(id)
    list_of_merchants = []
    list_of_invoices.map do |invoice|
      list_of_merchants << invoice.merchant
    end
    list_of_merchants
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id)
  end

  def find_invoices_by_customer_id(id)
    invoices.find_all_by_customer_id(id)
  end
end

# se = SalesEngine.from_csv({
# 	:items     => ARGV[0],
# 	:merchants => ARGV[1],
# })
#
# merchant = se.merchants.all
# item = se.items.all

# def find_average(merchant)
# 	top = setup_average(merchant).inject(0) {|sum, instance| sum + instance.length}
# 	bottom = setup_average(merchant).length
# 	average = top.to_f / bottom.to_f
# 	average.round(2)
# end
#
# def setup_average(merchant)
# 	all_merchants = []
# 		merchant.map do |merch|
# 			all_merchants << merch.items
# 		end
# 	all_merchants
# end

# puts "the average number of items per merchant is #{find_average(merchant)}"

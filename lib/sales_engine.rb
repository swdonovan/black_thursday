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

  def initialize(argv_val)
    @merchants      = MerchantRepository.new(argv_val[:merchants], self)
    @items          = ItemRepository.new(argv_val[:items], self)
    @invoices       = InvoiceRepository.new(argv_val[:invoices], self)
    @invoice_items  = InvoiceItemRepository.new(argv_val[:invoice_items], self)
    @transactions   = TransactionRepository.new(argv_val[:transactions], self)
    @customers      = CustomerRepository.new(argv_val[:customers], self)
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

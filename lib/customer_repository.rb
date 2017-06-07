require 'csv'
require_relative 'customer'
require 'time'

class CustomerRepository
  attr_reader :contents,
              :all,
              :se

  def inspect
		"#<#{self.class} #{@invoices.size} rows>"
	end

  def initialize(customer_info, se)
    @se = se
    @contents = CSV.open customer_info, headers: true, header_converters: :symbol
    read_lines
  end

  def read_lines
    @all = @contents.map do |row|
      Customer.new({:id => row[0], :first_name => row[1], :last_name => row[2],
      :created_at => row[3], :updated_at => row[4]}, self)
    end

    return all
  end

  def find_by_id(id)
    customer = all.select do |instance|
      instance if instance.id == id
    end
    return customer.shift
  end

  def find_all_by_first_name(first_name)
		customer = all.select do |instance|
			instance if instance.first_name.downcase.include?(first_name.downcase)
		end
		return customer
	end

  def find_all_by_last_name(last_name)
		customer = all.select do |instance|
			instance if instance.last_name.downcase.include?(last_name.downcase)
		end
		return customer
	end

	def get_merchants_from_se(id)
		se.find_merchants_by_customer_id(id)
	end

  def get_invoices_for_customer_id(id)
    se.find_invoices_by_customer_id(id)
  end

  def get_invoice_items_from_se(id)
    se.find_invoice_items_by_invoice_id(id)
  end
end

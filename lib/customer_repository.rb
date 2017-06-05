require 'csv'
require_relative 'customer'
require 'time'

class CustomerRepository
  attr_reader :contents,
              :all,
              :se

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
			instance if instance.first_name == first_name
		end
		return customer
	end

  def find_all_by_last_name(last_name)
		customer = all.select do |instance|
			instance if instance.last_name == last_name
		end
		return customer
	end
end

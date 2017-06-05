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
end

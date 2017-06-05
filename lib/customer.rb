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
    @cst                            = cst
    @id                             = customer_info[:id].to_i
    @created_at                     = Time.parse(customer_info[:created_at].to_s)
    @updated_at                     = Time.parse(customer_info[:updated_at].to_s)
    @first_name                     = customer_info[:first_name]
    @last_name                      = customer_info[:last_name]
  end
end
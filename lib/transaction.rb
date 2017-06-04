require 'csv'
require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :created_at,
              :updated_at,
              :tr,
							:result

  def initialize(transaction_info, tr)
    @tr                   				= tr
    @id                   				= transaction_info[:id].to_i
    @invoice_id           				= transaction_info[:invoice_id].to_i
    @credit_card_number  				  = transaction_info[:credit_card_number]
    @created_at           				= Time.parse(transaction_info[:created_at].to_s)
    @updated_at           				= Time.parse(transaction_info[:updated_at].to_s)
    @credit_card_expiration_date  = transaction_info[:credit_card_expiration_date]
		@result												= transaction_info[:result]
  end


end

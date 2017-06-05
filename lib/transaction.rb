require 'csv'
require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :created_at,
              :updated_at,
              :result,
              :tr

  def initialize(transactions_info, tr)
    @tr                          = tr
    @id                          = transactions_info[:id].to_i
    @invoice_id                  = transactions_info[:invoice_id].to_i
    @credit_card_number          = transactions_info[:credit_card_number].to_i
    @created_at                  = Time.parse(transactions_info[:created_at].to_s)
    @updated_at                  = Time.parse(transactions_info[:updated_at].to_s)
    @credit_card_expiration_date = transactions_info[:credit_card_expiration_date]
    @result                      = transactions_info[:result]
  end

  def invoice
    tr.get_invoice_from_se(invoice_id)
  end
end

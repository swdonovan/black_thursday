require 'csv'
require_relative 'transaction'
require 'time'

class TransactionRepository
  attr_reader :contents,
              :all,
              :se

  def initialize(transaction_info, se)
    @se = se
    @contents = CSV.open transaction_info, headers: true, header_converters: :symbol
    read_lines
  end

  def read_lines
    @all = @contents.map do |row|
      Transaction.new({:id => row[0], :invoice_id => row[1], :credit_card_number => row[2],
        :credit_card_expiration_date => row[3], :result => row[4], :created_at => row[5], :updated_at => row[6]}, self)
    end

    return all
  end

end

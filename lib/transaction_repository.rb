require 'csv'
require_relative 'transaction'
require 'time'

class TransactionRepository
  attr_reader :contents,
              :all,
              :se

  def inspect
		"#<#{self.class} #{@invoices.size} rows>"
	end

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

  def find_by_id(id)
    transaction = all.select do |instance|
      instance if instance.id == id
    end
    return transaction.shift
  end

  def find_all_by_invoice_id(invoice_id)
		invoice = all.select do |instance|
			instance if instance.invoice_id == invoice_id
		end
		return invoice
	end

  def find_all_by_credit_card_number(credit_card_number)
    credit_card_number = credit_card_number.to_i
		transaction = all.select do |instance|
			instance if instance.credit_card_number == credit_card_number
		end
		return transaction
	end

  def find_all_by_result(result)
		transaction = all.select do |instance|
			instance if instance.result == result
		end
		return transaction
	end

  def get_invoice_from_se(id)
    se.find_invoice_by_invoice_id(id)
  end
end

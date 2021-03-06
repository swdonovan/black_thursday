require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :name,
  :id,
  :contents,
  :all,
  :se

  def initialize(merchant_info, se)
    @se = se
    @all = nil
    @contents = CSV.open merchant_info, headers: true,
     header_converters: :symbol
    read_lines
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def read_lines
    @all = @contents.map do |row|
      Merchant.new({:id => row[0], :name => row[1]}, self)
    end
    return @all
  end

  def find_by_name(name)
    name = name.to_s.upcase
    merchant = nil
    @all.map do |word|
      merchant = word if name == word.name.upcase
    end
    return merchant
  end

  def find_by_id(id)
    id = id.to_i
    merchant = nil
    @all.map do |instance|
      merchant = instance if id == instance.id
    end
    return merchant
  end

  def find_all_by_name(segment)
    choices = @all.select do |merchant|
      merchant.name.upcase.include?(segment.upcase)
    end
    choices.map do |line|
      line#.name.to_s
    end
  end

  def pass_to_se_items(id)
    se.find_items_by_merchant_id(id)
  end

  def pass_to_se_invoices(id)
    se.find_invoice_by_merchant_id(id)
  end

  def get_customers_from_se(id)
    se.find_customers_by_merchant_id(id)
  end
end

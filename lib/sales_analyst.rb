require_relative 'sales_engine'
require 'date'
require 'time'

class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def all_merchants
    se.merchants.all
  end

  def average_items_per_merchant
    find_average(all_merchants)
  end

  def find_average(merchants)
    numerator = setup_avg(merchants).inject(0) do |sum, instance|
      sum + instance.length
    end
    average = numerator.to_f / find_denom(setup_avg(merchants)).to_f
    average.round(2)
  end

  def setup_avg(merchants)
    merchants_list = []
    merchants.map do |merch|
      merchants_list << merch.items
    end
    merchants_list
  end

  def average_items_per_merchant_standard_deviation
    average = find_average(all_merchants)
    setup = setup_avg(all_merchants)
    standard_deviation = standard_deviation_computation(setup, average)
  end

  def standard_deviation_computation(setup, average)
    st_dev = setup.inject(0) do |sum, instance|
      sum + ((instance.length - average)**2)
    end
    st_dev = Math.sqrt(st_dev / (setup.length - 1))
    st_dev.round(2)
  end

  def merchants_with_high_item_count
    st_d = average_items_per_merchant_standard_deviation
    find_high_item_merchants(st_d, all_merchants, find_average(all_merchants))
  end

  def find_high_item_merchants(st_d, setup, average)
    merchants = []
    setup.select do |merchant|
      merchants << merchant if merchant.items.length >= (st_d + average)
    end
    merchants
  end

  def setup_avg_instance(all_merchants)
    merchants = []
    all_merchants.map do |merch|
      merchants << merch
    end
    merchants
  end

  def average_item_price_for_merchant(id)
    returned_merchant = se.merchants.find_by_id(id)
    l_o_i = returned_merchant.items
    average_item_price = (find_num(l_o_i)) / (find_denom(l_o_i))
    average_item_price.round(2)
  end

  def find_num(items)
    items.inject(0) {|sum, item| sum + item.unit_price}
  end

  def find_denom(items)
    if items.length == 0
      return 1
    else
      items.length
    end
  end

  def average_average_price_per_merchant
    total = price_average
    total.round(2)
  end

  def find_average_prices(merchants)
    merchants.inject(0) do |sum, merch|
      sum + average_item_price_for_merchant(merch.id)
    end
  end

  def golden_items
    all_items = se.items.all
    average = find_average_price(all_items)
    st_d = average_price_per_item_standard_deviation(average, all_items)
    find_golden_items(st_d, all_items, average)
  end

  def average_price_per_item_standard_deviation(average, all_items)
    standard_deviation_price_computation(all_items, average)
  end

  def standard_deviation_price_computation(setup, average)
    st_dev = setup.inject(0) do |sum, instance|
      sum + ((instance.unit_price_to_dollars - average)**2)
    end
    st_dev = Math.sqrt(st_dev / (setup.length - 1))
    st_dev.round(2)
  end

  def find_average_price(all_items)
    average = find_price_average(all_items)
    average.round(2)
  end

  def find_price_numerator(items)
    items.inject(0) {|sum, item| sum + item_dollar_price(item)}
  end

  def find_golden_items(st_d, setup, average)
    golden_items = []
    two_sd = (((st_d - average) * 2) + average)
    setup.select do |item|
      golden_items << item if item_dollar_price(item) > two_sd
    end
    golden_items
  end

  def average_invoices_per_merchant
    merchants = all_merchants
    invoices = se.invoices.all
    average = average(invoices.length, merchants.length)
    average.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    setup = merch_invoice_instance
    standard_deviation_computation(setup, average)
  end

  def merch_invoice_instance
    all_merchants.map do |merchant|
      merchant.invoices
    end
  end

  def top_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    top_count = two_plus_std_devs(std_dev, average)
  end

  def two_plus_std_devs(std_dev, average)
    top_count = []
    two_sd = (average.to_f + (std_dev*2))
    all_merchants.select do |merchant|
      top_count << merchant if merchant.invoices.length >= two_sd
    end
    top_count
  end

  def two_minus_std_devs(std_dev, average)
    bottom_count = []
    all_merchants.select do |merchant|
      if merchant.invoices.length <= (average.to_f - (std_dev * 2))
        bottom_count << merchant
      end
    end
    bottom_count
  end

  def bottom_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    bottom_count = two_minus_std_devs(std_dev, average)
  end

  def top_days_by_invoice_count
    grouped_inv = date_group_invoices
    std_dev = days_of_the_week_standard_deviation(grouped_inv)
    days = days_above_two_stdevs(grouped_inv, std_dev)
  end

  def date_group_invoices
    by_day_inv = se.invoices.all.group_by do |invoice|
      created_on(invoice.created_at)
    end
  end

  def created_on(invoice_date)
    invoice_date.strftime("%A")
  end

  def days_of_the_week_standard_deviation(grouped_inv)
    average = days_of_the_week_average(grouped_inv)
    st_dev = grouped_inv.keys.inject(0) do |sum, day|
      sum + (((grouped_inv[day].length) - average)**2)
    end
    st_dev = Math.sqrt(st_dev / (grouped_inv.length - 1)); st_dev.round(2)
  end

  def days_of_the_week_average(grouped_inv)
    sum = grouped_inv.keys.inject(0) do |sum, date|
      sum + grouped_inv[date].length
    end
    average = sum.to_f / grouped_inv.length.to_f
  end

  def days_above_two_stdevs(grouped_inv, std)
    average = days_of_the_week_average(grouped_inv)
    day = []
    grouped_inv.keys.find_all do |days|
      day << days if grouped_inv[days].length > (average + std)
    end
    day
  end

  def average(numerator, denominator)
    numerator.to_f / denominator.to_f
  end

  def invoice_status(status)
    status = status
    desired_status = se.invoices.find_all_by_status(status).length.to_f
    all_status = se.invoices.all.length.to_f
    percentage = ((desired_status / all_status) * 100)
    percentage.round(2)
  end

  def top_buyers(num_o_buyers = 20)
    x = "#{num_o_buyers}"
    all_customers = top_customers(sort_invoices_by_total, x)
  end

  def top_customers(total_invoice_sum, x)
    total_invoice_sum[0..(x.to_i - 1)]
  end

  def sort_invoices_by_total
    all_customers = se.customers.all
    total_invoice_sum = all_customers.sort_by do |customer|
      paid_in_full_check(customer.invoices)
    end
    total_invoice_sum = total_invoice_sum.reverse
  end

  def paid_in_full_check(invoices)
    paid_invoices= invoices.each do |invoice|
      invoices.delete(invoice) if invoice.fully_paid? == false
    end
    sum_invoices(paid_invoices)
  end

  def sum_invoices(invoices)
    invoices.inject(0) do |sum, invoice|
      sum + invoice.total.to_f
    end
  end

  def top_merchant_for_customer(customer_id)
    ident = se.customers.find_by_id(customer_id)
    inv = ident.invoices
    grouped = group_invoices_by_merchant(inv)
    top_merchant(grouped)
  end

  def top_merchant(grouped)
    sorted_qty = grouped.keys.sort_by do |key|
      key = [sum_invoice_quantity(grouped[key])]
    end
    sorted_qty = sorted_qty.reverse
    se.merchants.find_by_id(sorted_qty[0])
  end

  def group_invoices_by_merchant(inv)
    inv.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def sum_invoice_quantity(grouped_key)
    sum = grouped_key.inject(0) do |sum, invoice|
      sum + invoice.total_quantity
    end
  end

  def one_time_buyers
    invoices = se.invoices.all.select { |invoice| invoice.is_paid_in_full?}
    find_single_trans_invoices(invoices)
  end

  def find_single_trans_invoices(invoices)
    single_trans = invoices.select do |invoice|
      invoice if invoice.transactions.length == 1
    end
    convert_to_customers(single_trans)
  end

  def convert_to_customers(single_trans)
    single_trans_by_cust = single_trans.map do |invoice|
      invoice.customer
    end
    get_one_time_buyers(single_trans_by_cust)
  end

  def get_one_time_buyers(single_trans_by_cust)
    single_trans_by_cust.select do |customer|
      customer if customer.invoices.length == 1
    end
  end

  def one_time_buyers_top_items
    single_buyer_invoices = one_time_buyers.map do |customer|
      customer.invoices
    end
    single_buyer_invoices = single_buyer_invoices.flatten
    single_items = single_buyer_invoices.map do |invoice|
      invoice.items
    end
    single_items = single_items.flatten.compact
    sorted_item_hash = single_items.group_by do |item|
      item.id
    end
    item_id = sorted_item_hash.keys.max_by do |key|
      sorted_item_hash[key].length
    end
    top_single_item = [se.items.find_by_id(item_id)]
    # top_item = [top_single_item]
  end

  def items_bought_in_year(customer_id, year)
    invoices = find_invoice_year(se.customers.find_by_id(customer_id), year)
    items = map_to_items(invoices)
    items.flatten
  end

  def find_invoice_year(customer, year)
    customer.invoices.find_all do |invoice|
      invoice.created_at.strftime("%Y").to_s == year.to_s
    end
  end

  def map_to_items(invoices)
    items = invoices.map do |invoice|
      invoice.items
    end
  end

  def highest_volume_items(customer_id)
    items_list = (se.customers.find_by_id(customer_id)).invoice_items.flatten
    items = group_by_item_id(items_list)
    sorted = regroup_by_quantity(items)
    sorted.map! do |item_ids|
      se.items.find_by_id(item_ids)
    end
  end

  def group_by_item_id(items_list)
    items_list.group_by do |item|
      item.item_id
    end
  end

  def regroup_by_quantity(items)
    sorted = items.keys.inject({}) do |key, item|
      key[item] = [items[item][0].quantity]; key
    end
    sorted.keys.select do |key|
      sorted[key] == sorted.values.max
    end
  end

  def customers_with_unpaid_invoices
    customer_list = se.customers.all
    customer_list.select do |customer|
      customer.invoices.any? {|invoice| invoice.is_paid_in_full? == false}
    end
  end

  # def paid_check(invoices)
  #   paid_check = invoices.flatten.select do |invoice|
  #     invoice if invoice.status == :pending && invoice.is_paid_in_full?
  #   end
  #   paid_check
  # end

  def best_invoice_by_revenue
    invoice_list = se.invoices.all
    calculate_invoice_totals(invoice_list)
  end

  def calculate_invoice_totals(invoice_list)
    invoice_totals = invoice_list.map do |invoice|
      invoice.total.to_f
    end
    find_top_invoice(invoice_totals, invoice_list)
  end

  def find_top_invoice(invoice_totals, invoice_list)
    top_invoice = invoice_list.select do |invoice|
      invoice.total.to_f == invoice_totals.max
    end
    top_invoice.pop
  end

  def best_invoice_by_quantity
    invoice_list = se.invoices.all
    calculate_invoice_quantities(invoice_list)
  end

  def calculate_invoice_quantities(invoice_list)
    invoice_totals = invoice_list.map do |invoice|
      invoice.total_quantity
    end
    find_largest_qty_invoice(invoice_list, invoice_totals)
  end

  def find_largest_qty_invoice(invoice_list, invoice_totals)
    top_invoice = invoice_list.select do |invoice|
      invoice.total_quantity == invoice_totals.max
    end
    top_invoice.shift
  end

  def find_price_average(all_items)
    find_price_numerator(all_items).to_f / find_denom(all_items).to_f
  end

  def price_average
    find_average_prices(all_merchants) / find_denom(all_merchants)
  end

  def item_dollar_price(item)
    item.unit_price_to_dollars
  end
end
# @sales_engine_dos = SalesEngine.from_csv({
#   :items     => './data/items.csv',
#   :merchants => './data/merchants.csv',
#   :invoices   => './data/invoices.csv',
#   :invoice_items => "./data/invoice_items.csv",
#   :transactions  => "./data/transactions.csv",
#   :customers     => "./test/data/customers_fixture.csv"
#   })
#   #
# sa = SalesAnalyst.new(@sales_engine_dos)
# sa.top_buyers(4)
########

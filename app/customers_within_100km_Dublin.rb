#!/usr/bin/env ruby
#############################################################################
#
# Usage: ruby customer_within_100km_Dublin [input_file|'data/gistfile1.txt']
#
#			slvkorytov@gmail.com
#############################################################################

require_relative '../lib/customers_list'


cust_file = (ARGV.first) ? ARGV.first : "data/gistfile1.txt"

cust_list = CustomersList.new(cust_file)
selected_customers = cust_list.select_customers(53.3381985, -6.2592576, 100, "user_id")

selected_customers.map { |c| {user_id: c['user_id'], name: c['name'] } }.each do |c|
	puts c.to_json
end


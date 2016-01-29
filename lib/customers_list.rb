require 'json'
require_relative 'gps_distance'

class CustomersList
	attr_accessor :customers
	
	def initialize cust_file_name
		raise "File #{cust_file_name} not found!" unless File.file? cust_file_name
		@customers = []
		File.readlines(cust_file_name).each do |line|
			@customers << JSON.parse(line)
		end
	end
	
	def select_customers latitude, longitude, distance, sort_field = "user_id"
		start_point = GpsDistance.new latitude, longitude
		@customers.select { |c| start_point.distance_to(c["latitude"].to_f, c["longitude"].to_f) <= distance }.sort_by { |c| c["user_id"].to_i }
	end
end

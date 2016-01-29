require 'customers_list'

RSpec.describe CustomersList do
	it "reports error if no file exists" do
		expect{CustomersList.new("not_existed_file.txt")}.to raise_error(/File .* not found!/)
	end
	it "reports error if file contains invalid json" do
		File.open('bad_json.txt', 'w') { |file| file.write("it is not json") }
		expect{CustomersList.new("bad_json.txt")}.to raise_error(JSON::ParserError)
		File.delete('bad_json.txt')
	end
	context "for valid file with customers" do
		before(:context) do
			text_data = [
			'{"latitude": "52.240382", "user_id": 10, "name": "Georgina Gallagher", "longitude": "-6.972413"}',
			'{"latitude": "53.2451022", "user_id": 4, "name": "Ian Kehoe", "longitude": "-6.238335"}',
			'{"latitude": "53.1302756", "user_id": 5, "name": "Nora Dempsey", "longitude": "-6.2397222"}',
			'{"latitude": "53.3381985", "user_id": 0, "name": "Dublin itself", "longitude": "-6.2592576"}',
			'{"latitude": "53.008769", "user_id": 11, "name": "Richard Finnegan", "longitude": "-6.1056711"}']
			File.open('tmp_json.txt', 'w') { |file| text_data.each { |t| file.puts(t) } }
			@custs = CustomersList.new("tmp_json.txt")
			@dublin_coord = [53.3381985, -6.2592576]
		end
		after(:context) do
			File.delete('tmp_json.txt')
		end
		it "gets all customers from file" do
			expect(@custs.customers.size).to eq(5)
		end
		it "selects a customer in Dublin when distance is 0 km" do
			selected = @custs.select_customers(@dublin_coord[0], @dublin_coord[1], 0)
			expect(selected.size).to eq(1)
			expect(selected[0]['name']).to eq("Dublin itself")
		end
		it "selected customers have 'name' and 'user_id' fields" do
			selected = @custs.select_customers(@dublin_coord[0], @dublin_coord[1], 100)
			expect(selected[0].key?('name')).to be true
			expect(selected[0].key?('user_id')).to be true
		end
		it "selects customers with distance less 100 km" do
			expect(@custs.select_customers(@dublin_coord[0], @dublin_coord[1], 100).size).to eq(4)
		end
		it "sorts customers by user_id" do
			selected = @custs.select_customers(@dublin_coord[0], @dublin_coord[1], 100)
			prev_id = -1
			selected.each do |c|
				expect(c["user_id"].to_i > prev_id).to be true
				prev_id = c["user_id"].to_i
			end
		end
	end
end
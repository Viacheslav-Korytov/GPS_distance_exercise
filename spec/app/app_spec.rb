RSpec.describe "Script for Customers within 100 km distance from Dublin" do
	before(:context) do
		@tmp_file = 'tmp_json.txt'
	end
	
	it "expects that no tmp file exists before testing" do
		expect(File.file?(@tmp_file)).to be false
	end
	
	context "running application" do
		before(:context) do
			command2run = "ruby app/customers_within_100km_Dublin.rb data/gistfile1.txt > #{@tmp_file}"
			`#{command2run}`
		end
		
		after(:context) do
			File.delete(@tmp_file)
		end
		
		it "creates an output file" do
			expect(File.file?(@tmp_file)).to be true
		end
		context "created file" do
			before(:context) do
				@customers = []
				File.readlines(@tmp_file).each do |line|
					@customers << JSON.parse(line)
				end
			end
			it "contains 'user_id' and 'name' fields" do
				@customers.each do |c|
					expect(c.key?('name')).to be true
					expect(c.key?('user_id')).to be true
				end
			end
			it "sorted by 'user_id'" do
				prev_id = -1
				@customers.each do |c|
					expect(c["user_id"].to_i > prev_id).to be true
					prev_id = c["user_id"].to_i
				end
			end
		end
	end
end

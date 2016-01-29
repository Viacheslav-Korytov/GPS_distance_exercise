require 'gps_distance'

RSpec.describe GpsDistance, "#distance_to" do
	context "For given latitude and longitude of two points" do
		before(:each) do
			@point_dublin = GpsDistance.new 53.3381985, -6.2592576
		end
		it "returns 0 if they are equal" do
			expect(@point_dublin.distance_to(53.3381985, -6.2592576)).to eq 0
		end
		it "returns > 1000 km for distance to N.Y." do
			expect(@point_dublin.distance_to(40.712784, -74.005941)).to be > 1000
		end
		it "returns < 100 km for Tullamore" do
			expect(@point_dublin.distance_to(53.275526, -7.493385)).to be < 100
		end
		it "returns > 100 km for Birr" do
			expect(@point_dublin.distance_to(53.098005, -7.909688)).to be > 100
		end
	end
end
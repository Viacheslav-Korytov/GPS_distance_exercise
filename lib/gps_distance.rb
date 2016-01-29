class GpsDistance

	# latitude, longitude of starting point
	def initialize(lat, lon)
		@rad_per_deg = Math::PI/180
		@rkm = 6371
		@lat1 = lat * @rad_per_deg
		@lon1 = lon * @rad_per_deg
	end
	
	# latitude, longitude of destination
	def distance_to(lat, lon)
		lat2 = lat * @rad_per_deg
		lon2 = lon * @rad_per_deg
		
		dlat = @lat1 - lat2
		dlon = @lon1 - lon2
		
		a = Math.sin(dlat/2)**2 + Math.cos(@lat1) * Math.cos(lat2) * Math.sin(dlon/2)**2
		c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
		
		c * @rkm
	end
	
end
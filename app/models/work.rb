class Work < ApplicationRecord

	def all_categories
		unique_categories = []
		
		self.all.each do |work|
			if !unique_categories.include?(work.category)
				unique_categories << work.category
			end
		end

		return unique_categories
	end
end

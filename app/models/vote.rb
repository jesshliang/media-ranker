class Vote < ApplicationRecord
	belongs_to :user
	belongs_to :work

	def count_votes(work_id, user_id)
		assoc_work = Work.find_by(id: work_id)
		assoc_work.increment(:vote_count)
		assoc_work.save

		assoc_user = User.find_by(id: user_id)
		assoc_user.increment(:vote_count)
		assoc_user.save
	end

	def find_user(id)
		return User.find_by(id: id).username
	end
end

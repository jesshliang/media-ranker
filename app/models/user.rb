class User < ApplicationRecord
	has_many :votes
	has_many :works, through: :votes

	validates :username, presence: true, uniqueness: true

	def self.current_user(id)
		return User.find_by(id: id).username
	end
end

class Work < ApplicationRecord
	has_many :votes
	has_many :users, through: :votes

	validates :category, presence: true
	validates :title, presence: true
	validates :creator, presence: true
	validates :publication_year, presence: true

	def self.top_media
		return Work.all
							 .order(vote_count: :desc, title: :asc)
							 .first
	end

	def self.top_books
		books = Work.where(category: 'book')
								.order(vote_count: :desc, title: :asc)
								.limit(10)
		return books
	end

	def self.top_albums
		albums = Work.where(category: 'album')
								 .order(vote_count: :desc, title: :asc)
								 .limit(10)
		return albums
	end

	def self.top_movies
		movies = Work.where(category: 'movie')
								 .order(vote_count: :desc, title: :asc)
								 .limit(10)
		return movies
	end

	def vote_date(user)
		return Vote.find_by(work_id: self.id, user_id: user.id).created_at.strftime("%m-%d-%Y")
	end
end

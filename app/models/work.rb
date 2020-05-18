class Work < ApplicationRecord
	has_many :votes
	has_many :users, through: :votes

	validates :category, presence: true
	validates :title, presence: true
	validates :creator, presence: true
	validates :publication_year, presence: true
	validates :description, presence: true

	def self.top_media
		return Work.all
							 .order(vote_count: :desc)
							 .first
	end

	def self.top_books
		books = Work.where(category: 'book')
								.order(vote_count: :desc)
								.limit(10)
		return books
	end

	def self.top_albums
		albums = Work.where(category: 'album')
								 .order(vote_count: :desc)
								 .limit(10)
		return albums
	end

	def self.top_movies
		movies = Work.where(category: 'movie')
								 .order('vote_count DESC')
								 .limit(10)
		return movies
	end

end

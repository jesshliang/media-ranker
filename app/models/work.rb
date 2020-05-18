class Work < ApplicationRecord
	has_many :votes
	has_many :users, through: :votes

	validates :category, presence: true
	validates :title, presence: true
	validates :creator, presence: true
	validates :publication_year, presence: true
	validates :description, presence: true

	def self.top_media
		return Work.all.sample
	end

	def self.top_books
		books = Work.includes(:votes)
								.where(category: "book")
								.references(:votes)
								.limit(10)
		return books
	end

	def self.top_albums
		albums = Work.joins(:votes)
		  					 .where(category: "album")
			  				 .group('works.id')
								 .order('count(votes.id) DESC')
								 .limit(10)
		return albums
	end

	def self.top_movies
		movies = Work.includes(:votes)
								 .where(category: "movie")
								 .references(:votes)
								 .limit(10)
		return movies
	end

end

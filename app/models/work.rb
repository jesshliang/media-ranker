class Work < ApplicationRecord

	def self.top_media
		return Work.all.sample
	end

	def self.top_books
		books = Work.where(category: "book")
		return books.sample(10)
	end

	def self.top_albums
		albums = Work.where(category: "album")
		return albums.sample(10)
	end

end

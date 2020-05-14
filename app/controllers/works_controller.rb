class WorksController < ApplicationController

	def index
		@albums = Work.where(category: 'album')
		@books = Work.where(category: 'book')
	end

end

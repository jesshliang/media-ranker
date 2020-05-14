class WorksController < ApplicationController

	def index
		@albums = Work.where(category: 'album')
		@books = Work.where(category: 'book')
	end

	def show
		@work = Work.find_by(id: params[:id])

		if @work.nil?
			head :not_found
			return
		end
	end

end

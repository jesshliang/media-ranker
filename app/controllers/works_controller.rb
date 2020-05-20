class WorksController < ApplicationController

	def index
		@movies = Work.where(category: 'movie')
									.order(vote_count: :desc, title: :asc)
		@books = Work.where(category: 'book')
								 .order(vote_count: :desc, title: :asc)
		@albums = Work.where(category: 'album')
									.order(vote_count: :desc, title: :asc)
	end

	def show
		@work = Work.find_by(id: params[:id])

		if @work.nil?
			head :not_found
			return
		end
	end

	def new
		@work = Work.new
	end

	def create
		@work = Work.new(work_params)

		if @work.save
			flash[:success] = "#{@work.title} added."
			redirect_to work_path(@work.id)
			return
		else
			flash.now[:failure] = "Error: this work could not be added."
			render :new, status: :bad_request
			return
		end
	end

	def edit
		@work = Work.find_by(id: params[:id])

		if @work.nil?
			redirect_to works_path
			return
		end
	end

	def update
		@work = Work.find_by(id: params[:id])

		if @work.nil?
			head :not_found
			return
		elsif @work.update(driver_params)
			redirect_to work_path(@work.id)
      flash[:success] = "#{@work.title} successfully updated"
      return
		else
			flash[:failure] = "#{@work.title} could not be updated."
      render :edit
      return
    end
	end

	def destroy
		@work = Work.find_by(id: params[:id])

		if @work.nil?
			flash[:failure] = "#{@work.title} could not be deleted."
			redirect_to works_path
			return
		end

		@work.destroy
		redirect_to works_path
		flash[:success] = "#{@work.title} was deleted."
		return
	end

	private

	def work_params
		return params.require(:work).permit(:title, :creator, :publication_year, :description, :category)
	end

end

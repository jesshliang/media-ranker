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
			flash.now[:failure] = "#{@work.title} could not be added."
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

	# def destroy
	# 	@driver = Driver.find_by(id: params[:id])

	# 	if @driver.nil?
	# 		redirect_to drivers_path
	# 		return
	# 	end

	# 	@driver.destroy

	# 	redirect_to drivers_path
	# 	flash[:success] = 'Driver removed'
	# 	return
	# end

	private

	def work_params
		return params.require(:work).permit(:title, :creator, :publication_year, :description, :category)
	end

end

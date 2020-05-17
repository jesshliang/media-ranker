class VotesController < ApplicationController

	def create
		@vote = Vote.new(
			user_id: session[:user_id],
			work_id: vote_params[:work_id]
		)

		if @vote.save
			flash[:success] = 'Upvoted!'
			redirect_to works_path
			return
		else
			flash.now[:error] = 'Error; could not be upvoted.'
			redirect_to works_path
			return
		end
	end

	def vote_params
		return params.require(:vote).permit(:work_id)
	end
	
end

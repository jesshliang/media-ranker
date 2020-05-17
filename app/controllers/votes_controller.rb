class VotesController < ApplicationController

	def create

		if session[:user_id]

			@vote = Vote.new(
				user_id: session[:user_id],
				work_id: params[:work_id]
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

		else
			flash[:unauthorized] = 'You cannot vote unless you are logged in.'
			redirect_to root_path
			return
		end
	end

	def vote_params
		return params.permit(:work_id)
	end
	
end

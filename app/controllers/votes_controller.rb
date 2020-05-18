class VotesController < ApplicationController

	def create
		if session[:user_id] # If the user is signed in,
			vote
		else # If the user is not signed in
			flash[:unauthorized] = 'You cannot vote unless you are logged in.'
			redirect_to root_path
			return
		end
	end

	def vote
		work_votes = Vote.where(work_id: params[:work_id], user_id: session[:user_id])

		if !work_votes.empty? # Has this user voted for this work before?
			flash[:failure]  = 'You cannot vote for a work more than once.'
			redirect_to root_path
			return
		else # User is signed in AND has not voted for this specific work before.
			@vote = Vote.new(
				user_id: session[:user_id],
				work_id: params[:work_id]
			)

			if @vote.save
				@vote.count_votes(params[:work_id], session[:user_id])

				flash[:success] = 'Upvoted!'
				redirect_to works_path
				return
			else
				flash.now[:error] = 'Error; could not be upvoted.'
				redirect_to works_path
				return
			end
		end
	end

	private 

	def vote_params
		return params.permit(:work_id)
	end
	
end

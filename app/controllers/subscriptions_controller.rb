class SubscriptionsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user,   only: :destroy
	
	def create
		@subscription = current_user.subscriptions.build(params[:subscription])
		a = @subscription
		a.save

		#flash[:success] = "Subscription Added!"
        redirect_to root_url
	end

	private

    def correct_user
      @subscription = current_user.subscriptions.find(params[:id])
    rescue
      redirect_to root_url
    end
end
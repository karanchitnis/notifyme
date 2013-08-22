class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @interest_items = current_user.subscriptions
      @feed_items = current_user.feed.paginate(page: params[:page])
      @subscription = current_user.subscriptions.build
    end
  end

  def help
  end

  def about
  end

  def contact
    @static_page = StaticPage.new
  end

  def create
    @static_page = StaticPage.create(params[:static_page])
    Suggestion.suggestion_box(@static_page).deliver
    redirect_to root_url
  end

  def del_sub
    @interest_items = current_user.subscriptions
    subscription = current_user.subscriptions.find params[:id]
    subscription.destroy
    #flash[:success] = "Subscription Deleted!"
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js
    end
  end
  
end

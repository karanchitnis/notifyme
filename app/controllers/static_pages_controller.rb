class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @interest_items = current_user.subscriptions
      @subscription = current_user.subscriptions.build
      if current_user.has_subscriptions?
        @user_subscription = current_user.last_read_or_default_subscription
        #@feed = Feedzirra::Feed.fetch_and_parse(@user_subscription.website).entries[0...Feed::MAX_COUNT]
        #@user_subscription.add_unread_items @feed
      end
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

  def feed_view
    current_user.subscriptions.each {|item| item.update_attribute :last_seen, false}
    subscription = current_user.subscriptions.find(params[:id])
    subscription.update_attribute :last_seen, true
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js
    end    
  end

  def subscription_button_title subscription
    if subscription.has_unread_feeds?
      "#{subscription.name} (#{subscription.unread_feeds_count})"
    else
      subscription.name
    end
  end

  helper_method :subscription_button_title

end

class SubscriptionsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user,   only: :destroy

	def create
		@subscription = current_user.subscriptions.build(params[:subscription])
		a = @subscription
		a.save

		if Interest.where(name: @subscription.name.downcase).first == nil
	        
			fb_url = Google::Search::Web.new(:query => @subscription.name.downcase + ' facebook').first.uri
			if fb_url[0..23] != "https://www.facebook.com"
				fb_url = nil
			end

			twit_url = Google::Search::Web.new(:query => @subscription.name.downcase + ' twitter').first.uri
			if twit_url[0..18] != "https://twitter.com"
				twit_url = nil
			end

			inst_url = Google::Search::Web.new(:query => @subscription.name.downcase + ' instagram').first.uri
			if inst_url[0..19] != "http://instagram.com"
				inst_url = nil
			end

			# SET YOU_URL TO THE OFFICIAL CHANNEL URL
			words = @subscription.name.downcase.split
	    	search = "http://www.youtube.com/results?search_query="
	        str = ""
	        index = 0
	        while index < words.count
	          if index == 0
	            str += words[0]
	            index += 1
	          else
	            str += "+" + words[index]
	            index += 1
	          end
	        end

	        search = search + str
	        @agent ||= init_agent
	        page = @agent.get search
	        channel = []
	        index = 0
	        page.search('.yt-lockup-tile').each do |item|
	        	if (item.at('.yt-badge') != nil) and (item.at('.yt-badge').text == "CHANNEL")
	        		if item.at('.yt-user-name') != nil
	        			channel[index] = item.at('.yt-user-name').text
	        		end
	        		index += 1
	        	end
	        end

	        # Take into account multiple channels (later will use split[','])
	        you_url = ""
	        pos = 0
	        while pos < channel.size
	        	# Super super weird bug
	        	if channel[pos] != "nocommenttv"
		        	if (pos == 0)
		        		you_url += "http://www.youtube.com/user/" + channel[0] + "/videos"
		        		pos += 1
		        	else
		        		you_url += ", " + "http://www.youtube.com/user/" + channel[pos] + "/videos"
		        		pos += 1
		        	end
		        end
	        end
	        
			# Placeholder, will instead use API to get the first x elements (not scrapping)
			youpage_url = nil

			# Do not know how to scrape hulu
			hulu_url = nil

			vine_url = Google::Search::Web.new(:query => @subscription.name.downcase + ' vine').first.uri
			if vine_url[0..19] != "http://seenive.com/u"
				vine_url = nil
			end

			link_url = Google::Search::Web.new(:query => @subscription.name.downcase + ' linkedin influencer').first.uri
			if link_url[0..33] != "http://www.linkedin.com/influencer"
				link_url = nil
			end

			goog_url = nil

			# Need to hardcode urls later
			fan_url = nil

			Interest.add_entry_to_interest(@subscription.name.downcase, fb_url, twit_url, inst_url, you_url, youpage_url, hulu_url, vine_url, link_url, goog_url, fan_url)
			
  		end

		# do fan_site (instagram api) last, waiting for API

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
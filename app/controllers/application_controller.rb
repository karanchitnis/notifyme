class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def init_agent
  	agent = Mechanize.new{|a| a.history.max_size = 10}
  	agent.user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5'
  	agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
  	agent
  end  

  def update_feed last_seen_name
  	if Interest.where(:name => last_seen_name.downcase).first != nil
	  	search_entry = Interest.where(:name => last_seen_name.downcase).first

	  	fbfeed = update_facebook search_entry.facebook
	  	twitfeed = update_twitter search_entry.twitter
	  	instfeed = update_facebook search_entry.instagram
		
		ret = fbfeed.concat(twitfeed).concat(instfeed)
		ret
	end
  end

  def update_facebook url
  	@agent ||= init_agent
  	fbpage = @agent.get url
  	ret = []
  	#fbpage.search('.message-item').each do |item|
    #	data = {}

  	ret
  end

  def update_twitter url
  	@agent ||= init_agent
  	twitpage = @agent.get url
  	ret = []
  	twitpage.search('ol.stream-items > li').each do |li|
  		data = {}
  		data[:title] = li.at('span.username').text.strip rescue nil
  		data[:description] = li.at('p.js-tweet-text').text.strip rescue nil
  		data[:date] = Time.at li.at('span._timestamp')['data-time'].to_i rescue nil
  		data[:url] = li.at('a.twitter-timeline-link')[:href] rescue nil
  		data[:image] = nil
  		data[:provider] = "twitter"
  		ret << data
  	end
  	ret
  end

  def update_instagram url
  	@agent ||= init_agent
  	instpage = @agent.get url
  	ret = []

  	ret
  end

end
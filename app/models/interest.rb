class Interest < ActiveRecord::Base
  attr_accessible :facebook, :fan_site, :google, :hulu, :instagram, :linkedin, :name, :twitter, :vine, :youtube, :youtube_page

  def self.add_entry_to_interest(name, fb_url, twit_url, inst_url, you_url, youpage_url, hulu_url, 
  		vine_url, link_url, goog_url, fan_url)
  	create! do |interest|
      interest.name = name
      interest.facebook = fb_url
      interest.twitter = twit_url
      interest.instagram = inst_url
      interest.youtube = you_url
      interest.youtube_page = youpage_url
      interest.hulu = hulu_url
      interest.vine = vine_url
      interest.linkedin = link_url
      interest.google = goog_url
      interest.fan_site = fan_url
      
      interest.save!
    end
  end
end

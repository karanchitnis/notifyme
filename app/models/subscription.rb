class Subscription < ActiveRecord::Base
  attr_accessible :name, :last_seen
  belongs_to :user
  has_many :feeds, autosave: true, dependent: :delete_all
  
  validates :name, presence: true, length: {minimum: 3}
  validates :user_id, presence: true

  def unread_feeds
    feeds.where unread: true
  end

  def unread_feeds_count
    unread_feeds.size
  end

  def has_unread_feeds?
    unread_feeds.size > 0
  end

  def unread_item? feed
    unread_feeds.where(:url => feed.url).any?
  end

  def transfer_init_feeds init_feeds
    for feed in init_feeds
      title = feed[:title]
      description = feed[:description]
      date = feed[:date]
      url = feed[:url] 
      image = feed[:image]
      provider = feed[:provider]
      unread = true
      self.feeds << Feed.new(:title => title, :description => description, :date => date, :url => url, :image => image, :provider => provider, :unread => unread)
    end
  end

  private

#  def delete_oldest_feed
#    feeds.last.delete if feeds.size > Feed::MAX_COUNT
#  end

end
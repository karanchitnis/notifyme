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

  private

#  def delete_oldest_feed
#    feeds.last.delete if feeds.size > Feed::MAX_COUNT
#  end

end
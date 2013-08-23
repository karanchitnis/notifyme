class Feed < ActiveRecord::Base
  attr_accessible :date, :description, :image, :provider, :title, :unread, :url
  belongs_to :subscription
end

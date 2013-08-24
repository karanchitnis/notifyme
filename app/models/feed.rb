class Feed < ActiveRecord::Base
  attr_accessible :date, :description, :image, :provider, :title, :unread, :url
  default_scope order('date DESC')
  
  belongs_to :subscription
end

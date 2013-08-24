class AddLastSeenToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_seen, :boolean, :default => false
  end
end

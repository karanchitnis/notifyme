class RemoveLastReadFromSubscriptions < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :last_read
  end

  def down
    add_column :subscriptions, :last_read, :boolean
  end
end

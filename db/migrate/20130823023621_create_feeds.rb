class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :provider
      t.datetime :date
      t.boolean :unread, :default => true
      t.string :image
      t.string :title
      t.string :url
      t.text :description
      t.integer :subscription_id

      t.timestamps
    end
    add_index :feeds, :subscription_id
  end
end

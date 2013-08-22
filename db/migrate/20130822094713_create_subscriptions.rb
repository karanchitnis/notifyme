class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.integer :user_id
      
      t.timestamps
    end
    add_index :subscriptions, [:user_id, :created_at]
  end
end

class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :youtube
      t.string :youtube_page
      t.string :hulu
      t.string :vine
      t.string :linkedin
      t.string :google
      t.string :fan_site

      t.timestamps
    end
  end
end

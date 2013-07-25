class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|

      t.timestamps
    end
  end
end

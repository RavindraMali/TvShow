class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.integer :channel_id

      t.timestamps
    end
    add_index :shows, :name,          unique: true
  end
end

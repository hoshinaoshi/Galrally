class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :movie_id
      t.string :thumbnail_url
      t.integer :site
      t.boolean :scraping_flag
      t.boolean :new_flag

      t.timestamps
    end
    add_index :shows, :site
    add_index :shows, :scraping_flag
    add_index :shows, :new_flag
  end
end

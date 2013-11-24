class CreateScrapingHistories < ActiveRecord::Migration
  def change
    create_table :scraping_histories do |t|
      t.string :movie_id
      t.integer :site

      t.timestamps
    end
    add_index :scraping_histories, :site
  end
end

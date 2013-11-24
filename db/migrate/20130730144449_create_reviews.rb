class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :movie_id
      t.string :thumbnail_url
      t.integer :site

      t.timestamps
    end
    add_index :reviews, :site
  end
end

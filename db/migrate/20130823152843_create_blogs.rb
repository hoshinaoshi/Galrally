class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :content

      t.timestamps
    end
    add_column :shows, :blog_id, :integer
    add_index :shows, :blog_id
  end
end

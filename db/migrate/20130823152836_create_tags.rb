class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag

      t.timestamps
    end
    add_column :shows, :tag_id, :integer
    add_index :shows, :tag_id
    add_index :tags, :tag
  end
end

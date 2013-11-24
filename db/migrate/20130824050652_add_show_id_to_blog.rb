class AddShowIdToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :show_id, :integer
    add_index :blogs, :show_id
  end
end

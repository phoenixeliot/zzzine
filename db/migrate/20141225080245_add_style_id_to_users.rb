class AddStyleIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :style_id, :integer
  end
end

class AddUserIdToStyles < ActiveRecord::Migration
  def change
    add_column :styles, :user_id, :integer
  end
end

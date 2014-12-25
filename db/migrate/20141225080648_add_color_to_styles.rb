class AddColorToStyles < ActiveRecord::Migration
  def change
    add_column :styles, :color, :string
  end
end

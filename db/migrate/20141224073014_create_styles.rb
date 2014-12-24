class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.integer :style_id
      t.string :slug
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end

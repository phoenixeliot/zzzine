class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :title
      t.integer :tweet_id

      t.timestamps
    end
  end
end

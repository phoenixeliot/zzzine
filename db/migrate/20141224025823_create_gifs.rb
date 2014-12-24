class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.string :hashtag
      t.string :title
      t.integer :tweet_id

      t.timestamps
    end
  end
end

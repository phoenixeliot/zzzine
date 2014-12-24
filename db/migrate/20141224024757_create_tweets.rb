class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
      t.datetime :date
      t.integer :favorites

      t.timestamps
    end
  end
end

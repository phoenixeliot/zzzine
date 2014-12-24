class AddImportantToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :importance, :integer
  end
end

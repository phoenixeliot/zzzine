# == Schema Information
#
# Table name: gifs
#
#  id         :integer          not null, primary key
#  hashtag    :string(255)
#  tweet_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  url        :string(255)
#

class Gif < ActiveRecord::Base
	belongs_to :tweet
end

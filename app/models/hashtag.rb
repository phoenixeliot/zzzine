# == Schema Information
#
# Table name: hashtags
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  tweet_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Hashtag < ActiveRecord::Base
	belongs_to :tweet
end

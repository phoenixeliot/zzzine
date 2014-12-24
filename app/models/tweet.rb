# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  date       :datetime
#  favorites  :integer
#  created_at :datetime
#  updated_at :datetime
#  url        :string(255)
#  importance :integer
#

class Tweet < ActiveRecord::Base
	belongs_to :user
	has_many :hashtags
	has_one :gif
end

# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  val        :integer
#  created_at :datetime
#  updated_at :datetime
#

class Status < ActiveRecord::Base
	belongs_to :user
end

# == Schema Information
#
# Table name: styles
#
#  id         :integer          not null, primary key
#  style_id   :integer
#  slug       :string(255)
#  name       :string(255)
#  order      :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  color      :string(255)
#

class Style < ActiveRecord::Base
	has_many :users
end

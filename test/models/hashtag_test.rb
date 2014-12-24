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

require 'test_helper'

class HashtagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

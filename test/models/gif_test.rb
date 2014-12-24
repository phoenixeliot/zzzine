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

require 'test_helper'

class GifTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

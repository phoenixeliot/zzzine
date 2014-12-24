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
#

require 'test_helper'

class StyleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

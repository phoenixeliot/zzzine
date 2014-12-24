# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string(255)
#  uid                    :string(255)
#  token                  :string(255)
#  secret                 :string(255)
#  status                 :integer
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
     :omniauthable, :omniauth_providers => [:twitter]

  has_many :tweets

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth['info']['nickname']).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth['info']['nickname']
        user.email = auth['info']['nickname'] + "@twitter.com"
        user.password = Devise.friendly_token[0,20]
        user.token = auth['credentials']['token']
    	user.secret = auth['credentials']['secret']
      end
  end
end

# == Schema Information
#
# Table name: authentications
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  uid          :integer
#  provider     :string(190)      not null
#  access_token :string(190)
#  expires_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Authentication < ActiveRecord::Base
  # attr_accessible :user_id, :provider, :uid, :access_token

  belongs_to :user

  validates :provider, :uid, :access_token, presence: true
  validates :provider, uniqueness: { scope: :user_id }

  def self.create_from_hash(user_id, omniauth)
    self.create!(
      user_id:      user_id,
      provider:     omniauth.provider,
      uid:          omniauth.uid,
      access_token: omniauth.credentials.token
    )
  end
end

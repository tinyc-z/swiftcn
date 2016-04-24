# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(190)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(190)      not null
#  is_banned              :boolean          default("0"), not null
#  avatar                 :string(255)
#  password               :string(255)      default("0"), not null
#  topics_count           :integer          default("0"), not null
#  replies_count          :integer          default("0"), not null
#  notifications_count    :integer          default("0"), not null
#  city                   :string(255)
#  company                :string(255)
#  twitter_account        :string(255)
#  personal_website       :string(255)
#  signature              :string(255)
#  introduction           :string(255)
#  deleted_at             :datetime
#  reset_password_token   :string(190)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
   # :registerable,:recoverable,
  devise :database_authenticatable,
          :rememberable,:registerable, :trackable, :omniauthable, omniauth_providers:[:github]

  acts_as_paranoid

  has_many :topics

end

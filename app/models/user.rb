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

  delegate :github_name, :goodbye, to: :authentication

  acts_as_paranoid

  include CounterStat #统计
  include RoleAble
  include ExistsAble

  validates_length_of :city, :maximum => 50, :allow_blank => true
  validates_length_of :company, :maximum => 50, :allow_blank => true
  validates_length_of :twitter_account, :maximum => 191, :allow_blank => true
  validates_length_of :personal_website, :maximum => 191, :allow_blank => true
  validates_length_of :signature, :maximum => 191, :allow_blank => true
  validates_length_of :introduction, :maximum => 191, :allow_blank => true
  
  belongs_to :role
  has_many :topics#, dependent: :destroy
  has_many :replies#, dependent: :destroy

  has_many :sttentions#, dependent: :destroy
  has_many :favorites#, dependent: :destroy

  has_many :event_logs

  has_one :github,->{where(provider:'github')},class_name:'Authentication'
  
  before_create :set_default_role
  
  # def to_param
  #   "#{name}"
  # end

  def calendar_data
    Rails.cache.fetch("#{cache_key}/activities_data",expires_in:5.minutes) do
      event_logs = self.event_logs.where("created_at > ?",1.years.ago).group("date(created_at)").count
      event_logs.map { |date,count| [date.to_time.to_i,count] }.to_h
    end
  end


  private
  def set_default_role
    self.role = Role.registered
  end

end

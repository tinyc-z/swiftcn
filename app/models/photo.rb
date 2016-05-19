# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  image      :string(191)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photo < ActiveRecord::Base
  belongs_to :user

  include CounterStat #统计
  include BaseModel

  validates_presence_of :image
  
  mount_uploader :image, PhotoUploader

  def url
    self.image.try(:url)
  end
  
end

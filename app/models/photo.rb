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

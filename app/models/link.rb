# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  title      :string(191)
#  link       :string(191)
#  cover      :string(191)
#  sort       :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Link < ActiveRecord::Base

  mount_uploader :cover, FriendLinkUploader
  
  def cover=(str) #数据迁移用
    if str.is_a?(String)
      self[:cover] = str
    else
      super
    end
  end

end

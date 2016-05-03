# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: appends
#
#  id         :integer          not null, primary key
#  topic_id   :integer
#  content    :text(65535)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Append < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :topic
  belongs_to :user

  validates :content, :presence => true
  
end

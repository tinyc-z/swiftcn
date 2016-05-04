# == Schema Information
#
# Table name: attentions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attention < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
end

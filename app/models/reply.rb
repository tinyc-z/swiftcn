# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: replies
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  topic_id      :integer
#  body          :text(65535)
#  body_original :text(65535)
#  is_blocked    :boolean          default("0")
#  votes_count   :integer          default("0")
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Reply < ActiveRecord::Base
  acts_as_paranoid

  include CounterStat #统计
  include VoteAble #点赞
  include BodyPipeline #生成body
  include EventLogAble

  validates :body, :presence => true
  validates :user, :presence => true
  validates :topic, :presence => true
  
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true
  has_many :votes, as: :votable, dependent: :destroy

  default_scope ->{ where(is_blocked: false) }

  private
  after_create :set_last_reply_user
  def set_last_reply_user
    if topic_id
      Topic.where(id:topic_id).update_all(last_reply_user_id:user_id,updated_at: DateTime.now)
    end
  end
  
  after_destroy :roll_back_last_reply_user
  def roll_back_last_reply_user
    if topic_id
      reply = Reply.where(topic_id:topic_id).last
      if reply
        Topic.where(id:topic_id).update_all(last_reply_user_id:reply.user_id,updated_at: reply.created_at)
      end
    end
  end

end


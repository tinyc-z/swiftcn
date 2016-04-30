class Reply < ActiveRecord::Base
  acts_as_paranoid

  include CounterStat #统计
  include VoteAble #点赞
  include BodyPipeline #生成body
  include ExistsAble

  validates :body, :presence => true
  validates :user, :presence => true
  validates :topic, :presence => true
  
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true
  has_many :votes, as: :votable, dependent: :destroy

  default_scope { where(is_blocked: false) }


  private
  after_create :set_last_reply_user
  def set_last_reply_user
    if self.topic_id
      Topic.where(id:self.topic_id).update_all(last_reply_user_id:self.user_id,updated_at: DateTime.now)
    end
  end
  
  after_destroy :roll_back_last_reply_user
  def roll_back_last_reply_user
    if self.topic_id
      reply = Reply.where(topic_id:self.topic_id).last
      if reply
        Topic.where(id:self.topic_id).update_all(last_reply_user_id:reply.user_id,updated_at: reply.created_at)
      end
    end
  end

end


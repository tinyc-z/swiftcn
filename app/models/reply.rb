class Reply < ActiveRecord::Base
  acts_as_paranoid

  include CounterStat #统计
  include VoteAble #点赞
  
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true
  has_many :votes, as: :votable, dependent: :destroy



  private
  after_create :set_last_reply_user
  def set_last_reply_user
    if self.topic_id
      Topic.where(id:self.topic_id).update_all(last_reply_user_id:self.user_id)
    end
  end


end


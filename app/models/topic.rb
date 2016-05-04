# == Schema Information
#
# Table name: topics
#
#  id                 :integer          not null, primary key
#  title              :string(191)      not null
#  body               :text(65535)
#  body_original      :text(65535)
#  excerpt            :text(65535)
#  is_excellent       :boolean          default("0")
#  is_wiki            :boolean          default("0")
#  is_blocked         :boolean          default("0")
#  replies_count      :integer          default("0")
#  view_count         :integer          default("0")
#  favorites_count    :integer          default("0")
#  votes_count        :integer          default("0")
#  last_reply_user_id :integer
#  order              :integer          default("0")
#  node_id            :integer          not null
#  user_id            :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#

class Topic < ActiveRecord::Base

  acts_as_paranoid

  include CounterStat #统计
  include VoteAble #vote up
  include AttentionAble #attention
  include FavoriteAble #收藏
  include BodyPipeline #生成body
  include EventLogAble
  
  belongs_to :user, :counter_cache => true
  belongs_to :node, :counter_cache => true

  validates_length_of :title, :minimum => 5, :maximum => 120, :allow_blank => false

  validates :body, :presence => true
  validates :user, :presence => true
  validates :node, :presence => true

  has_many :appends#, dependent: :destroy
  has_many :replies#, dependent: :destroy
  has_many :attentions#, dependent: :destroy
  has_many :favorites#, dependent: :destroy

  has_one :last_reply_user, class_name: 'User', primary_key: :last_reply_user_id,foreign_key: :id

  has_many :votes, as: :votable, dependent: :destroy

  default_scope -> { where(is_blocked: false) }
  
  before_save :build_excerpt

  # def to_param
  #   "#{id}-#{URI.encode(title.gsub(".", "").gsub(" ", "-"))}" 
  # end

  #BodyPipeline 回调
  def can_mention_user?(login)
    return User.exists?(name:login)
  end

  def similar_topics(limit=8,shuffle=false)
    topics = Topic.where(node:node).where.not(id:id)
    if shuffle
      topics.limit(limit*5).sample(limit)
    else
      topics.limit(limit)
    end
  end

  def has_reply?
    replies_count > 0
  end

  def self.filter(name)
    if name == 'recent' #最近发表
      order('id DESC')
    elsif name == 'excellent' #精华主题
      where(is_excellent:true).order('id DESC')
    elsif name == 'vote' #最多投票
      order('votes_count DESC') 
    elsif name == 'noreply' #最多投票
      order('replies_count') 
    else
      order('updated_at DESC')
    end
  end

  def fix_last_reply_user
    reply = Reply.where(topic:self).last
    if reply.present?
      self.update_column(:last_reply_user,reply.user)
    end
  end

  protected
  def build_excerpt
    if body.present?
      self.excerpt = ActionController::Base.helpers.sanitize(body,:tags=>[]).squish.truncate(110)
    end
  end

end

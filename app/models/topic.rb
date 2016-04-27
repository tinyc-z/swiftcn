# == Schema Information
#
# Table name: topics
#
#  id                 :integer          not null, primary key
#  title              :string(190)      not null
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

  include VoteUp #vote up
  include TopicAttention #attention
  include CounterStat #统计

  belongs_to :user, :counter_cache => true
  belongs_to :node, :counter_cache => true

  has_many :appends, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :attentions , dependent: :destroy

  has_one :last_reply_user, class_name: 'User', primary_key: :last_reply_user_id,foreign_key: :id

  has_many :votes, as: :votable, dependent: :destroy

  

  def similar_topics(limit=8,shuffle=false)
    topics = Topic.where(node_id:self.node_id).where.not(id: self.id)
    if shuffle
      topics.limit(limit*5).sample(limit)
    else
      topics.limit(limit)
    end
  end

  def has_reply?
    self.replies_count > 0
  end

end

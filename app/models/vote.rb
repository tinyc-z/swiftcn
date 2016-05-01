# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  votable_id   :integer
#  votable_type :string(191)
#  is           :string(191)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ActiveRecord::Base

  include CounterStat #统计
  include EventLogAble

  belongs_to :topic#, :counter_cache => true #have a bug
  belongs_to :reply#, :counter_cache => true
  belongs_to :user

  after_save :touch_counter_cache
  after_destroy :touch_counter_cache

  def touch_counter_cache
    votes_count = Vote.where(votable_id:self.votable_id,votable_type:votable_type).count
    if votable_type == 'Topic'
      Topic.where(id:self.votable_id).update_all({votes_count:votes_count})
    elsif votable_type == 'Reply'
      Reply.where(id:self.votable_id).update_all({votes_count:votes_count})
    end
  end


end

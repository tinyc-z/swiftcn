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

  after_create :increment_counter_cache
  after_destroy :decrement_counter_cache

  protected
  def increment_counter_cache
    if votable_id.present?
      if votable_type == 'Topic'
        Topic.increment_counter(:votes_count,votable_id)
      elsif votable_type == 'Reply'
        Reply.increment_counter(:votes_count,votable_id)
      end
    end
  end

  def decrement_counter_cache
    if votable_id.present?
      if votable_type == 'Topic'
        Topic.decrement_counter(:votes_count,votable_id)
      elsif votable_type == 'Reply'
        Reply.decrement_counter(:votes_count,votable_id)
      end
    end
  end


end

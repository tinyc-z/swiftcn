class Vote < ActiveRecord::Base

  include CounterStat #统计

  belongs_to :topic#, :counter_cache => true #have a bug
  belongs_to :reply#, :counter_cache => true

  after_save :touch_counter_cache
  after_destroy :touch_counter_cache

  def touch_counter_cache
    votes_count = Vote.where(votable_id:self.votable_id,votable_type:self.votable_type).count
    if self.votable_type == 'Topic'
      Topic.where(id:self.votable_id).update_all({votes_count:votes_count})
    elsif self.votable_type == 'Reply'
      Reply.where(id:self.votable_id).update_all({votes_count:votes_count})
    end
  end


end

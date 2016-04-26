class Vote < ActiveRecord::Base
  belongs_to :topic#, :counter_cache => true #have a bug
  belongs_to :reply#, :counter_cache => true

  after_save :touch_counter_cache
  after_destroy :touch_counter_cache 

  scope :up, ->{ where(is:'up') }
  scope :down, ->{ where(is:'down') }

  def touch_counter_cache
    votes_count = Vote.where(votable_id:self.votable_id,votable_type:self.votable_type).count
    if self.votable_type == 'Topic'
      Topic.where(id:self.votable_id).update_all({votes_count:votes_count})
    elsif self.votable_type == 'Reply'
      Reply.where(id:self.votable_id).update_all({votes_count:votes_count})
    end
  end

  private
  after_create :for_stat
  def for_stat
    if self.is == 'up'
      SiteStatus.inc_vote_up  
    else
      SiteStatus.inc_vote_down  
    end
  end

end

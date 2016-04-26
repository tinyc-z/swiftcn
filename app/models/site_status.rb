class SiteStatus < ActiveRecord::Base

  def self.today
    SiteStatus.where(created_at:Time.now.all_day).first || SiteStatus.new(day_at:Time.now)
  end

  def self.inc_register
    inc_counter :register_count
  end

  def self.inc_topic
    inc_counter :topic_count
  end

  def self.inc_reply
    inc_counter :topic_count
  end

  def self.inc_vote_up
    inc_counter :vote_up_count
  end

  def self.inc_vote_down
    inc_counter :vote_down_count
  end  
  
  def self.inc_image
    inc_counter :image_count
  end

  private
  def self.inc_counter(sym)
    status = self.today
    status.update_attribute(sym,status[sym]+1)
  end

end

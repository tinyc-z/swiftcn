class SiteStatus < ActiveRecord::Base

  def self.today
    SiteStatus.where(create_at:Time.now.all_day).first || SiteStatus.new(day_at:Time.now)
  end

  def inc_register
    s = self.today.inc_register_count += 1 
    s.save
  end

  def inc_topic
    s = self.today.inc_topic_count += 1 
    s.save
  end

  def inc_reply
    s = self.today.inc_reply_count += 1 
    s.save
  end
  
  def inc_image
    s = self.today.inc_image_count += 1 
    s.save
  end

end

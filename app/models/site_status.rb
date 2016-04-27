class SiteStatus < ActiveRecord::Base

  def self.today
    SiteStatus.where(created_at:Time.now.all_day).first || SiteStatus.new(day_at:Time.now)
  end
  
  def self.method_missing(m, *args, &block)
    method_name = m.to_s
    if (method_name =~ /^inc_/) != nil
      method_name = method_name[4..100]
      self.send(:inc_counter,"#{method_name}_count")
    else
      super
    end
  end  

  private
  def self.inc_counter(sym)
    status = self.today
    status.update_attribute(sym,status[sym]+1)
  end

end

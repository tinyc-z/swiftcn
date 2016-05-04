module CounterStat
  extend ActiveSupport::Concern

  included do
    after_create :for_stat
  end
  
  def for_stat
    SiteStatus.send("inc_#{self.class.to_s.underscore}")
  end
end

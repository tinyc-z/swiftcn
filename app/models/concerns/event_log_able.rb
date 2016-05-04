module EventLogAble
  extend ActiveSupport::Concern

  included do
    after_create :log_create_event
  end
  
  def log_create_event
    EventLog.create(user:user,entity_id:id,entity_type:"create_#{self.class.to_s.underscore}")
  end

end

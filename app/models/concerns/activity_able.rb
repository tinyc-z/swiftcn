module ActivityAble
  extend ActiveSupport::Concern

  included do
     after_create :log_create_activity
  end
  
  def log_create_activity
    Activity.create(user_id:self.user_id,entity_id:self.id,entity_type:"create_#{self.class.to_s.underscore}")
  end

end
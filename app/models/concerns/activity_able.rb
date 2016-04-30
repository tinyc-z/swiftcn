module ActivityAble
  extend ActiveSupport::Concern

  included do
     before_create :log_create_activity
  end
  
  def log_create_activity
    Activities.create(user_id:user_id,entity_id:id,entity_type:"create_#{self.class.to_s.underscore}")
  end

end
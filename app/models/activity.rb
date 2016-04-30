class Activity < ActiveRecord::Base

  belongs_to :user

  def self.build_histroy_activitys
    unless Activity.first
      Topic.find_each do |single|
        Activity.create(user_id:single.user_id,entity_id:single.id,entity_type:"create_#{single.class.to_s.underscore}",created_at:single.created_at);
      end
      Reply.find_each do |single|
        Activity.create(user_id:single.user_id,entity_id:single.id,entity_type:"create_#{single.class.to_s.underscore}",created_at:single.created_at);
      end
    end
  end
end

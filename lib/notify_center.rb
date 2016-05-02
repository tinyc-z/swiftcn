# -*- encoding : utf-8 -*-
class NotifyCenter

  def create_if_needed(scope)
    if Notification.where(scope).exists?
      false
    else
      Notification.create(scope).errors.blank?
    end
  end
  
  def self.topic_attent(user,topic)
    return if user.id == topic.user_id 
    create_if_needed(user_id:topic.user_id,from_user_id:user.id,topic_id:topic.id,notify_type:'topic_attent')  
  end

  def self.topic_favorite(user,topic)
    return if user.id == topic.user_id 
    create_if_needed(user_id:topic.user_id,from_user_id:user.id,topic_id:topic.id,notify_type:'topic_favorite')
  end

  def self.topic_mark_excellent(user,topic)
    return if user.id == topic.user_id 
    create_if_needed(user_id:topic.user_id,from_user_id:user.id,topic_id:topic.id,notify_type:'topic_mark_excellent')
  end

  def self.topic_mark_wiki(user,topic)
    return if user.id == topic.user_id 
    create_if_needed(user_id:topic.user_id,from_user_id:user.id,topic_id:topic.id,notify_type:'topic_mark_wiki')
  end

  def self.topic_upvote(user,topic)
    return if user.id == topic.user_id 
    create_if_needed(user_id:topic.user_id,from_user_id:user.id,topic_id:topic.id,notify_type:'topic_upvote')
  end

  def self.reply_upvote(user,reply)
    return if user.id == reply.user_id 
    create_if_needed(user_id:reply.user_id,from_user_id:user.id,reply_id:reply.id,topic_id:reply.topic_id,notify_type:'reply_upvote')
  end

  def self.topic_replied(topic,reply)
    #notifi topic's author
    if topic.user_id != reply.user_id
      scope = {user_id:topic.user_id,from_user_id:reply.user_id,reply_id:reply.id,topic_id:topic.id,notify_type:'new_reply'}
      if create_if_needed(scope)
        # Notifier.fire_notify()
      end
    end

    #@提到的人
    reply.mention_users.each do |user_name|
      mention_user = User.where(name:user_name).first
      if mention_user && (mention_user != topic.user && mention_user != reply.user)
        
      end
    end

    

    

  end


end

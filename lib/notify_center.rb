class NotifyCenter

  def self.create_if_needed(scope)
    if Notification.where(scope.except(:body)).exists?
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
    create_if_needed(body:reply.body,user_id:reply.user_id,from_user_id:user.id,entity_id:reply.id,topic_id:reply.topic_id,notify_type:'reply_upvote')
  end

  def self.topic_replied(topic,reply)
    #notifi topic's author
    replied_notify_author_topic_replied(topic,reply)
    #通知被@提到的人
    replied_notify_reply_at_users(topic,reply)
    #通知关注topic的人
    replied_notify_topic_attention_users_by_reply(topic,reply)
  end

  def self.topic_append(topic,append)
    #通知所有回复过的人
    append_notify_topic_replied_users(topic, append)
    #通知所有关注topic的人
    append_notify_append_topic_users(topic, append)
  end

  #通知所有回复过的人
  def self.append_notify_topic_replied_users(topic,append)
    topic.replies.includes(:user).each do |reply|
      if reply.user && (append.user_id != reply.user_id)
        reply_scope ||= {body:append.content,from_user_id:append.user_id,entity_id:append.id,topic_id:topic.id,notify_type:'comment_append'}
        scope = reply_scope.merge(user_id:reply.user_id)
        create_if_needed(scope)
      end
    end
  end

  #通知所有关注topic的人
  def self.append_notify_append_topic_users(topic,append)
    topic.attentions.includes(:user).each do |attention|
      if append.user && (append.user_id != attention.user_id)
        append_scope ||= {body:append.content,from_user_id:append.user_id,entity_id:append.id,topic_id:topic.id,notify_type:'attention_append'}
        scope = append_scope.merge(user_id:attention.user_id)
        create_if_needed(scope)
      end
    end
  end

  #通知帖子作者
  def self.replied_notify_author_topic_replied(topic,reply)
    if topic.user_id != reply.user_id
      replied = {body:reply.body,user_id:topic.user_id,from_user_id:reply.user_id,entity_id:reply.id,topic_id:topic.id,notify_type:'new_reply'}
      if create_if_needed(replied)
        SendUnreadMailJob.perform_later(topic.user) if Rails.env.production?
      end
    end
  end

  #通知被@提到的人
  def self.replied_notify_reply_at_users(topic,reply)
    reply.mention_users.each do |user_name|
      mention_user = User.where(name:user_name).first
      if mention_user && (mention_user.id != topic.user_id && mention_user.id != reply.user_id)
        mention_scope ||= {body:reply.body,from_user_id:reply.user_id,entity_id:reply.id,topic_id:topic.id,notify_type:'at'}
        scope = mention_scope.merge(user_id:mention_user.id)
        if create_if_needed(scope)
          SendUnreadMailJob.perform_later(mention_user) if Rails.env.production?
        end
      end
    end
  end

  #通知关注topic的人
  def self.replied_notify_topic_attention_users_by_reply(topic,reply)
    topic.attentions.includes(:user).each do |attention|
      if attention.user && (attention.user_id != topic.user_id && attention.user_id != reply.user_id)
        attention_scope ||= {body:reply.body,from_user_id:reply.user_id,entity_id:reply.id,topic_id:topic.id,notify_type:'attention_append'}
        scope = attention_scope.merge(user_id:attention.user_id)
        create_if_needed(scope)
      end
    end
  end

end

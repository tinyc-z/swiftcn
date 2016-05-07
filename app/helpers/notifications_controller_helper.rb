module NotificationsControllerHelper

  def topic_path_with_notify(notify)
    if notify.entity_id.to_i > 0
      topic_path(notify.topic,reply:notify.entity_id)+"#reply#{notify.entity_id}"
    else
      topic_path(notify.topic)
    end
  end

  def action_text(notify) 
    case notify.notify_type
      when 'new_reply'
        lang('site.Your topic have new reply:')
      when 'attention'
        lang('site.Attented topic has new reply:')
      when 'at'
        lang('site.Mention you At:')
      when 'topic_favorite'
        lang('site.Favorited your topic:')
      when 'topic_attent'
        lang('site.Attented your topic:')
      when 'topic_upvote'
        lang('site.Up Vote your topic:')
      when 'reply_upvote'
        lang('site.Up Vote your reply:')
      when 'topic_mark_wiki'
        lang('site.has mark your topic as wiki:')
      when 'topic_mark_excellent'
        lang('site.has recomended your topic:');
      when 'comment_append'
        lang('site.Commented topic has new update:');
      when 'attention_append'
        lang('site.Attented topic has new update:');
    end
  end
end
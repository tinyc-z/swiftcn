# -*- encoding : utf-8 -*-
module BodyPipeline
  extend ActiveSupport::Concern

  def context
    @context ||= {
        link_attr: 'target="_blank"',
        base_url:'/users',
        gfm: true,
        delegate: self
    }
  end

  def body_original=(text)
    super
    if self.body_original_changed?
      pipeline = HTML::Pipeline.new([
        # HTML::Pipeline::ImageFilter,
        HTML::Pipeline::MarkdownFilter,
        HTML::Pipeline::SanitizationFilter,
        PipelineLinkFilter,
        HTML::Pipeline::MentionFilter
      ], context)
      result = pipeline.call(text)
      @mention_users = result[:mentioned_usernames]
      self.body = result[:output].to_html
    end
  end

  def mention_users
    unless @mention_users
      filter = HTML::Pipeline::MentionFilter.new(body_original,context)
      filter.call
      @mention_users = filter.result[:mentioned_usernames]
    end
    @mention_users
  end

end

class HTML::Pipeline::MentionFilter

  #根据源码改造
  # https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/@mention_filter.rb
  MentionLogins.clear
  
  def link_to_mentioned_user(login)
    result[:not_mentioned_usernames] ||= []
    delegate = context[:delegate] 
    if !result[:not_mentioned_usernames].include?(login) && 
         (result[:mentioned_usernames].include?(login) ||
         (!delegate || !delegate.respond_to?(:can_mention_user?)) || 
         (delegate.respond_to?(:can_mention_user?) && delegate.can_mention_user?(login)))

      result[:mentioned_usernames] |= [login]
      url = base_url.dup
      url << "/" unless url =~ /[\/~]\z/

      "<a href='#{url}#{login}' class='user-mention'>@#{login}</a>"
    else
      result[:not_mentioned_usernames] |= [login]
      return nil
    end
  end

end

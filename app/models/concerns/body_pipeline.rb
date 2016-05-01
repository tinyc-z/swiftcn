module BodyPipeline
  extend ActiveSupport::Concern

  def body_original=(text)
    super
    if self.body_original_changed?
      context = {
        link_attr: 'target="_blank"',
        base_url:'/users',
        gfm: true
      }
      pipeline = HTML::Pipeline.new([
        HTML::Pipeline::MarkdownFilter,
        # HTML::Pipeline::ImageFilter,
        HTML::Pipeline::SanitizationFilter,
        PipelineLinkFilter,
        HTML::Pipeline::MentionFilter
      ], context)

      result = pipeline.call(text)
      self.body = result[:output].to_html
    end
  end

end

class HTML::Pipeline::MentionFilter
    #根据源码改造
    #https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/@mention_filter.rb
    def mention_link_filter(text, base_url='/', info_url=nil, username_pattern=UsernamePattern)
      self.class.mentioned_logins_in(text, username_pattern) do |match, login, is_mentioned|
        link = link_to_mentioned_user(login)
        if link && User.where(name:login).exists? 
          match.sub("@#{login}", link)
        else
          match
        end
      end
    end
end
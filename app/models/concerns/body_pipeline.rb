module BodyPipeline
  extend ActiveSupport::Concern

  def body_original=(text)
    super
    if self.body_original_changed?
      context = {
        link_attr: 'target="_blank"',
        base_url:'/',
        gfm: true
      }
      pipeline = HTML::Pipeline.new([
        HTML::Pipeline::ImageFilter,
        HTML::Pipeline::MarkdownFilter,
        HTML::Pipeline::SanitizationFilter,
        PipelineLinkFilter
      ], context)
      result = pipeline.call(text)
      self.body = result[:output].to_html
    end
  end

end
class TopicsController < ApplicationController
  
  def index
    @nodes = Node.is_parent.includes(:childs)
    @topics = Topic.paginate(:page => params[:page])
    @links = Link.all
    # @filter
    # topics
  end

  def show
    @topic = Topic.find params_id
    @replies = @topic.has_reply? ? @topic.replies.paginate(:page => params[:page]) : []
    @similar_topics = @topic.similar_topics(8,true)
    # @links = Link.all
    @tip = Tip.first
  end

end

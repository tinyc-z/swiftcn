class TopicsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @nodes = Node.is_parent.includes(:childs)
    @topics = Topic.order('id DESC').includes(:user,:node,:last_reply_user).paginate(:page => params[:page])
    @links = Link.all
    # @filter
    # topics
  end

  def show
    @topic = Topic.find(params_id)
    @replies = @topic.has_reply? ? @topic.replies.includes(:user).order('id DESC').paginate(:page => params[:page]) : []
    @similar_topics = @topic.similar_topics(8,true)
    @tip = Tip.first
    # @links = Link.all
  end

  def toggle_up_vote
    @topic = Topic.find(params_id)
    @last_vote_up = @topic.vote_up?(current_user)
    if @last_vote_up
      @topic.cancel_vote_up(current_user)
    else
      @topic.vote_up(current_user)
    end
    @topic.reload
  end

  def toggle_attention
    @topic = Topic.find(params_id)
    @did_attention = @topic.did_attention?(current_user)
    if @did_attention
      @topic.remove_attention(current_user)
    else
      @topic.add_attention(current_user)
    end
    @topic.reload
  end

end

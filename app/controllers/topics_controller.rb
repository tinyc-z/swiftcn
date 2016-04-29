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

    @reply = Reply.new
    # @links = Link.all
  end

  def destroy
    @topic = Topic.find(params_id)
    authorize! :manage, @topic
    @topic.destroy
    redirect_to root_path
  end

  def toggle_up_vote
    @topic = Topic.find(params_id)
    authorize! :update, Vote
    @last_vote_up = @topic.vote_up?(current_user)
    if @last_vote_up
      @topic.cancel_vote_up(current_user)
    else
      @topic.vote_up(current_user)
    end
    @topic.reload
  end

  def toggle_attention
    topic = Topic.find(params_id)
    @did_attention = topic.did_attention?(current_user)
    if @did_attention
      topic.remove_attention(current_user)
    else
      topic.add_attention(current_user)
    end
  end

  def toggle_favorit
    topic = Topic.find(params_id)
    @did_favorit = topic.did_favorit?(current_user)
    if @did_favorit
      topic.remove_favorit(current_user)
    else
      topic.add_favorit(current_user)
    end
  end

  def toggle_recomend
    topic = Topic.find(params_id)
    authorize! :manage, topic
    @is_excellent = !topic.is_excellent
    topic.update_attribute(:is_excellent,@is_excellent)
  end

  def toggle_wiki
    topic = Topic.find(params_id)
    authorize! :manage, topic
    @is_wiki = !topic.is_wiki
    topic.update_attribute(:is_wiki,@is_wiki)
  end

  def toggle_pin
    topic = Topic.find(params_id)
    authorize! :manage, topic
    topic.update_attribute(:order,topic.order == 1 ? 0 : 1)
    redirect_to topic
  end

  def toggle_sink
    topic = Topic.find(params_id)
    authorize! :manage, topic
    topic.update_attribute(:order,topic.order == -1 ? 0 : -1)
    redirect_to topic
  end

end

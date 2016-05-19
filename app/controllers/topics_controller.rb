class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_resource

  def new
    @topic.node_id = params[:node_id]
  end

  def edit
    render 'new'
  end

  def update
    authorize! :update, @topic
    if @topic.update_attributes(create_params.merge(updated_at:DateTime.now))
      redirect_to @topic
    else
      render 'new'
    end
  end

  def create
    @topic.user = current_user
    if @topic.save
      SendAdminNotifiMailJob.perform_later(topics_url(@topic))
      redirect_to @topic
    else
      flash.now[:alert] = @topic.errors.full_messages
      render 'new'
    end
  end

  def index
    @nodes = Node.is_parent.includes(:childs)
    @topics = @topics.filter(params[:filter]).includes(:user,:node,:last_reply_user).page(params_page)
    @links = Link.all
  end

  def show
    @replies = @topic.has_reply? ? @topic.replies.includes(:user).page(params_page) : []
    @similar_topics = @topic.similar_topics(8,true)
    @tip = Tip.first
    @reply = Reply.new
    Topic.increment_counter(:view_count,@topic.id)
    # @links = Link.all
  end

  def destroy
    authorize! :manage, @topic
    @topic.destroy
    redirect_to root_path
  end

  def toggle_up_vote
    authorize! :update, Vote
    @last_vote_up = @topic.vote_up?(current_user)
    if @last_vote_up
      @topic.cancel_vote_up(current_user)
    else
      @topic.vote_up(current_user)
      NotifyCenter.topic_upvote(current_user,@topic)
    end
    @topic.reload
  end

  def toggle_recomend
    authorize! :manage, @topic
    @is_excellent = !@topic.is_excellent
    NotifyCenter.topic_mark_excellent(current_user,@topic) if @is_excellent
    @topic.update_attribute(:is_excellent,@is_excellent)
  end

  def toggle_wiki
    authorize! :manage, @topic
    @is_wiki = !@topic.is_wiki
    NotifyCenter.topic_mark_wiki(current_user,@topic) if @is_wiki
    @topic.update_attribute(:is_wiki,@is_wiki)
  end

  def toggle_pin
    authorize! :manage, @topic
    @topic.update_attribute(:order,@topic.order == 1 ? 0 : 1)
    redirect_to @topic
  end

  def toggle_sink
    authorize! :manage, @topic
    @topic.update_attribute(:order,@topic.order == -1 ? 0 : -1)
    redirect_to @topic
  end

  protected
  def create_params
    params.require(:topic).permit(:body_original,:title).merge(node_id:params[:node_id])
  end

end

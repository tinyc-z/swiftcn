# -*- encoding : utf-8 -*-
class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_resource, except: [:new,:create,:index]

  def new
    @topic = Topic.new
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

  def append
    authorize! :update, @topic
    append = @topic.appends.create(params.require(:append).permit(:content))
    redirect_to @topic, alert:append.errors.full_messages
  end

  def create
    @topic = Topic.new(create_params)
    @topic.user = current_user
    if @topic.save
      redirect_to @topic
    else
      flash.now[:alert] = @topic.errors.full_messages
      render 'new'
    end
  end

  def index
    @nodes = Node.is_parent.includes(:childs)
    @topics = Topic.filter(params[:filter]).includes(:user,:node,:last_reply_user).paginate(params_page)
    @links = Link.all
    # @filter
    # topics
  end

  def show
    @replies = @topic.has_reply? ? @topic.replies.includes(:user).paginate(params_page) : []
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

  def toggle_attention
    @did_attention = @topic.did_attention?(current_user)
    if @did_attention
      @topic.remove_attention(current_user)
    else
      @topic.add_attention(current_user)
      NotifyCenter.topic_attent(current_user,@topic)
    end
  end

  def toggle_favorit
    @did_favorit = @topic.did_favorit?(current_user)
    if @did_favorit
      @topic.remove_favorit(current_user)
    else
      @topic.add_favorit(current_user)
      NotifyCenter.topic_favorite(current_user,@topic)
    end
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

  def load_resource
    @topic = Topic.find(params_id)
  end

end

# -*- encoding : utf-8 -*-
class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_resource, except: [:create]

  def create
    authorize! :create, Reply
    topic = Topic.find(params[:topic_id])
    reply = topic.replies.build(create_params)
    reply.user = current_user
    if reply.save
      NotifyCenter.topic_replied(topic,reply)
    end
    redirect_to topic, alert: reply.errors.full_messages
  end

  def toggle_up_vote
    authorize! :update, Vote
    @last_vote_up = @reply.vote_up?(current_user)
    if @last_vote_up
      @reply.cancel_vote_up(current_user)
    else
      @reply.vote_up(current_user)
      NotifyCenter.reply_upvote(current_user,@reply)
    end
    @reply.reload
  end

  def destroy
    authorize! :destroy, @reply
    @reply.destroy
    redirect_to topic_path(@reply.topic_id)
  end


  protected
  def create_params
    params.permit(:body_original)
  end

  def load_resource
    @reply = Reply.find(params_id)
  end
end

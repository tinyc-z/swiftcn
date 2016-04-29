class RepliesController < ApplicationController
  before_filter :authenticate_user! #, except: [:index, :show]

  def create
    authorize! :create, Reply
    topic = Topic.find(params[:topic])
    reply = topic.replies.build({body_original:params[:reply_content]})
    reply.user = current_user
    reply.save
    redirect_to topic, :flash => { :errors => reply.errors.full_messages }
  end

  def toggle_up_vote
    @reply = Reply.find(params_id)
    authorize! :update, Vote
    @last_vote_up = @reply.vote_up?(current_user)
    if @last_vote_up
      @reply.cancel_vote_up(current_user)
    else
      @reply.vote_up(current_user)
    end
    @reply.reload
  end

  def destroy
    reply = Reply.find(params_id)
    authorize! :destroy, reply
    reply.destroy
    redirect_to topic_path(reply.topic_id)
  end

  def params_create
    params.permit(:reply_content)
  end

end
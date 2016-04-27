class RepliesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]


  def toggle_up_vote
    @reply = Reply.find(params_id)
    @last_vote_up = @reply.vote_up?(current_user)
    if @last_vote_up
      @reply.cancel_vote_up(current_user)
    else
      @reply.vote_up(current_user)
    end
    @reply.reload
  end

end
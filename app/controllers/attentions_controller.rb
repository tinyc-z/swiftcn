class AttentionsController < ApplicationController
  before_action :authenticate_user!
  
  def toggle_attention
    @topic = Topic.find(params[:topic_id])
    authorize! :update, Attention
    @did_attention = @topic.did_attention?(current_user)
    if @did_attention
      @topic.remove_attention(current_user)
    else
      @topic.add_attention(current_user)
      NotifyCenter.topic_attent(current_user,@topic)
    end
  end

end
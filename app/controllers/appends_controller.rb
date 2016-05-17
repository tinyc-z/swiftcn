class AppendsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @topic = Topic.find(params[:topic_id])
    authorize! :update, @topic
    append = @topic.appends.new(params.require(:append).permit(:content))
    append.user = current_user
    if append.save
      NotifyCenter.topic_append(@topic,append)
    end
    redirect_to @topic, alert:append.errors.full_messages
  end

end

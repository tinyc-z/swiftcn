class FavoritsController < ApplicationController
  before_action :authenticate_user!
  
  def toggle_favorit
    @topic = Topic.find(params[:topic_id])
    authorize! :update, Favorite
    @did_favorit = @topic.did_favorit?(current_user)
    if @did_favorit
      @topic.remove_favorit(current_user)
    else
      @topic.add_favorit(current_user)
      NotifyCenter.topic_favorite(current_user,@topic)
    end
  end

end
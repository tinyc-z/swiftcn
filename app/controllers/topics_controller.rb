class TopicsController < ApplicationController
  
  def index
    @nodes = Node.is_parent.includes(:childs)
    @topics = Topic.limit(20)
    # @filter
  end

  def show
    @topic = Topic.find params_id
  end

end

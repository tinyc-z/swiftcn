class TopicsController < ApplicationController
  
  def index
    @nodes = Node.is_parent.includes(:childs)
    @topics = Topic.limit(20)
    # @filter
  end

  def show
    
  end

end

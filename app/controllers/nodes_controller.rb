class NodesController < ApplicationController
  
  def show
    @node = Node.find params_id
    @topics = @node.topics
  end

end

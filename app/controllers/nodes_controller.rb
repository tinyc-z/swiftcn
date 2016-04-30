class NodesController < ApplicationController
  
  def show
    @node = Node.find params_id
    @topics = @node.topics.order('updated_at DESC')
  end

end

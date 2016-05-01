# -*- encoding : utf-8 -*-
class NodesController < ApplicationController
  
  def show
    @node = Node.find params_id
    @topics = @node.topics.includes(:user,:node,:last_reply_user).filter(params[:filter]).paginate(params_page)
  end

  def jobs
    @node = Node.new(id:Settings.JOB_DEFAULT_NODE)
    @node.name = 'site.Jobs'.lang
    @topics = Topic.where(node_id:Settings.JOB_NODES).includes(:user,:node,:last_reply_user).filter(params[:filter]).paginate(params_page)
    render 'show'
  end

end

class NodesController < ApplicationController
  
  def show
    @node = Node.find params_id
    @topics = @node.topics.includes(:user,:node,:last_reply_user).order('updated_at DESC').paginate(:page => params[:page])
  end

  def jobs
    @node = Node.new
    @node.name = t('site.Jobs',default:'site.Jobs'.split('.').last)
    @topics = Topic.where(node_id:[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,25,26,27]).includes(:user,:node,:last_reply_user).order('updated_at DESC').paginate(:page => params[:page])
    render 'show'
  end

end

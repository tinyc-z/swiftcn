class UsersController < ApplicationController

  def index
    @site_stat = Stat.singleton
    @users = User.last(48);
  end

  def show
    @user = User.find params_id
    @replies = @user.replies.includes(:topic).last(20)
    @topics = @user.topics.includes(:node).last(20)
  end

  def replies
    @user = User.find params_id
    @replies = @user.replies.includes(:topic).paginate(:page => params[:page])
  end

  def topics
    @user = User.find params_id
    @topics = @user.topics.includes(:node).paginate(:page => params[:page])
  end

  def favorites
    @user = User.find params_id
    @favorites = @user.favorites.paginate(:page => params[:page])
    @topics = Topic.where(id:@favorites.pluck(:topic_id)).includes(:node)
  end

  def login
  
  end

  def activities
    @user = User.find params_id
    render :json => @user.activities_data
  end

  def ban
    user = User.find params_id
    authorize! :manage, user
    user.ban!
    redirect_to user
  end

  def free
    user = User.find params_id
    authorize! :manage, user
    user.free!
    redirect_to user
  end

end

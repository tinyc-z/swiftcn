class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:ban, :free]
  before_action :load_resource, except: [:index]

  def index
    @site_stat = Stat.singleton
    @users = User.last(48);
  end

  def show
    @replies = @user.replies.includes(:topic).last(20)
    @topics = @user.topics.includes(:node).last(20)
  end

  def edit
  end

  def update
    @user.update_attributes(update_params)
    redirect_to edit_user_path, :flash => { :errors => @user.errors.full_messages }
  end

  def replies
    @replies = @user.replies.includes(:topic).paginate(params_page)
  end

  def topics
    @topics = @user.topics.includes(:node).paginate(params_page)
  end

  def favorites
    @favorites = @user.favorites.paginate(params_page)
    @topics = Topic.where(id:@favorites.pluck(:topic_id)).includes(:node)
  end

  def login
  
  end

  def calendar
    render :json => @user.calendar_data
  end

  def ban
    authorize! :manage, @user
    @user.ban!
    redirect_to @user
  end

  def free
    authorize! :manage, @user
    @user.free!
    redirect_to @user
  end

  protected
  def load_resource
     # 处理有大写字母的情况
    if params_id != params_id.downcase
      redirect_to request.path.downcase, status: 301
      return
    end
    @user = User.find(params_id)
  end

  def update_params
    params.require(:user).permit(:city,:company,:twitter_account,:personal_website,:signature,:introduction)
  end

end

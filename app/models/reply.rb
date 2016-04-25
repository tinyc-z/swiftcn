class Reply < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :user, :counter_cache => true
  belongs_to :topic, :counter_cache => true

  has_many :votes, as: :votable, dependent: :destroy

  private
  after_create :for_stat
  def for_stat
    SiteStatus.inc_reply
  end

end


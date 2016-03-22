class Topic < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :user, :counter_cache => true
  belongs_to :node, :counter_cache => true

end

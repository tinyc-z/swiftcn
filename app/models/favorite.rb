class Favorite < ActiveRecord::Base
  belongs_to :topic
  has_one :user
end

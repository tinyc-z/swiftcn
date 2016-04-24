class Attention < ActiveRecord::Base
  belongs_to :topic
  has_one :user
end

class Append < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :topic

  validates :content, :presence => true
  
end

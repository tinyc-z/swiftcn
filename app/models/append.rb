class Append < ActiveRecord::Base
  acts_as_paranoid

  include BodyPipeline #生成body

  belongs_to :topic

  validates :body, :presence => true
  
end

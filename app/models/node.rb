class Node < ActiveRecord::Base
  acts_as_paranoid
  
  has_many :topics


end

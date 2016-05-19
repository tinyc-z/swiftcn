# == Schema Information
#
# Table name: tips
#
#  id         :integer          not null, primary key
#  body       :string(191)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tip < ActiveRecord::Base
  include BaseModel

  scope :rand_one, ->{ offset(rand(self.count)).first }

end

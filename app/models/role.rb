# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(191)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# ['registered', 'banned', 'editer', 'admin']

class Role < ActiveRecord::Base
  has_many :users

  def self.registered
    Role.find_or_create_by(name:'registered')
  end

  def self.editer
    Role.find_or_create_by(name:'editer')
  end

  def self.admin
    Role.find_or_create_by(name:'admin')
  end

  def registered?
    name == 'registered'
  end

  def editer?
    name == 'editer'
  end

  def admin?
    name == 'admin'
  end
end

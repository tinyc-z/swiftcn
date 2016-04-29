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
    self.name == 'registered'
  end

  def editer?
    self.name == 'editer'
  end

  def admin?
    self.name == 'admin'
  end
end

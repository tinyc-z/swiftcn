module RoleAble
  extend ActiveSupport::Concern

  def admin?
    self.role.admin?
  end

  def editer?
    self.role.editer?
  end

  def is_member?
    self.role.registered?
  end

  def ban?
    self.is_banned
  end

  def ban!
    self.update_column(:is_banned,true)
  end

  def free!
    self.update_column(:is_banned,false)
  end

end
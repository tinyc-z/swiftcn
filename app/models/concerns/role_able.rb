module RoleAble
  extend ActiveSupport::Concern

  def admin?
    role&&role.admin?
  end

  def editer?
    role&&role.editer?
  end

  def is_member?
    role&&role.registered?
  end

  def ban?
    is_banned
  end

  def ban!
    update_column(:is_banned,true)
  end

  def free!
    update_column(:is_banned,false)
  end

end

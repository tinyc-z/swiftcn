# -*- encoding : utf-8 -*-
module UsersControllerHelper

  def active_for_page?(pars)
    current_page?(pars) ? 'active' : ''
  end

end

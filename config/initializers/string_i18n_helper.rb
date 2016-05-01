# -*- encoding : utf-8 -*-
class String
  def lang(pars={})
    I18n.t(self,{default:self.split('.').last}.merge(pars))
  end

  def clean_white_spaces
    self.delete(' ')
  end
end


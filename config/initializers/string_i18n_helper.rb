class String
  def lang
    I18n.t(self,default:self.split('.').last)
  end
end


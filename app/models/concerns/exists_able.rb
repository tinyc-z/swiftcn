module ExistsAble
  def self.exists?(id)
    self.where(id:id).exists?
  end
end
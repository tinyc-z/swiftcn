# -*- encoding : utf-8 -*-
module FavoriteAble
  extend ActiveSupport::Concern

  def did_favorit?(user)
    self.favorites.where(user_id:user.id).exists? if user
  end

  def remove_favorit(user)
    self.favorites.where(user_id:user.id).destroy_all
  end

  def add_favorit(user)
    self.favorites.find_or_create_by(user_id:user.id)
  end
end

# -*- encoding : utf-8 -*-
module FavoriteAble
  extend ActiveSupport::Concern

  def did_favorit?(user)
    favorites.exists?(user:user) if user
  end

  def remove_favorit(user)
    favorites.where(user:user).destroy_all
  end

  def add_favorit(user)
    favorites.find_or_create_by(user:user)
  end
end

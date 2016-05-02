# -*- encoding : utf-8 -*-
module AttentionAble
  extend ActiveSupport::Concern

  def did_attention?(user)
    attentions.exists?(user:user) if user
  end

  def remove_attention(user)
    attentions.where(user:user).destroy_all
  end

  def add_attention(user)
    attentions.find_or_create_by(user:user)
  end
end


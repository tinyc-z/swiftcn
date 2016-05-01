# -*- encoding : utf-8 -*-
module AttentionAble
  extend ActiveSupport::Concern

  def did_attention?(user)
    self.attentions.where(user_id:user.id).exists? if user
  end

  def remove_attention(user)
    self.attentions.where(user_id:user.id).destroy_all
  end  

  def add_attention(user)
    self.attentions.find_or_create_by(user_id:user.id)
  end
end


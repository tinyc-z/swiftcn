# -*- encoding : utf-8 -*-
module VoteAble
  extend ActiveSupport::Concern

  def vote_up?(user)
    self.votes.where(user_id:user.id).exists? if user
  end

  def vote_up(user)
    self.votes.find_or_create_by(user_id:user.id)
  end

  def cancel_vote_up(user)
    self.votes.where(user_id:user.id).destroy_all
  end

end

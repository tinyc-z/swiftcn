module VoteAble
  extend ActiveSupport::Concern

  def vote_up?(user)
    votes.exists?(user:user) if user
  end

  def vote_up(user)
    votes.find_or_create_by(user:user)
  end

  def cancel_vote_up(user)
    votes.where(user:user).destroy_all
  end

end

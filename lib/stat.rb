class Stat

  attr_accessor :topic_count, :reply_count, :user_count

  def self.singleton
    Rails.cache.fetch("Stat/singleton", expires_in: 10.minutes) do
      stat = Stat.new  
      stat.topic_count = Topic.count
      stat.reply_count = Reply.count
      stat.user_count  = User.count
      stat
    end
  end

  def self.topic_count
    self.singleton.topic_count
  end

  def self.reply_count
    self.singleton.reply_count
  end

  def self.user_count
    self.singleton.user_count
  end

  def self.re_cache

  end
end

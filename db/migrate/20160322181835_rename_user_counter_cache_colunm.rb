# -*- encoding : utf-8 -*-
class RenameUserCounterCacheColunm < ActiveRecord::Migration
  def change
    rename_column :users ,:topic_count ,:topics_count
    rename_column :users ,:reply_count ,:replies_count
    rename_column :users ,:notification_count ,:notifications_count
  end
end

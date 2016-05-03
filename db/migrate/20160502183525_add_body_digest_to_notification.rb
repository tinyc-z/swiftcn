class AddBodyDigestToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :body_digest, :text
  end
end

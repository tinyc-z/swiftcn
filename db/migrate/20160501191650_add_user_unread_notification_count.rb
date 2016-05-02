class AddUserUnreadNotificationCount < ActiveRecord::Migration
  def change
    add_column :users, :unread_notification_count, :integer ,default:0
  end
end

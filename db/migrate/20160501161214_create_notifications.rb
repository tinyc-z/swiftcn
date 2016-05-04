class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      
      t.integer :from_user_id
      t.integer :user_id
      
      t.integer :topic_id
      t.integer :reply_id

      t.text :body
      t.string :notify_type

      t.timestamps null: false
    end
  end
end

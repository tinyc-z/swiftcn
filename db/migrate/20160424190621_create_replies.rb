class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :topic_id
      
      t.text :body
      t.text :body_original

      t.boolean :is_blocked, default:false

      t.integer :votes_count, default:0

      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :replies, :topic_id
    add_index :replies, :user_id
  end
end

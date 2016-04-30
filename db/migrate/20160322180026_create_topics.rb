class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.string :title, null: false, limit:190

      t.text :body
      t.text :body_original
      t.text :excerpt

      t.boolean :is_excellent, default:false
      t.boolean :is_wiki, default:false
      t.boolean :is_blocked, default:false

      t.integer :replies_count, default:0
      t.integer :view_count, default:0
      t.integer :favorites_count, default:0
      t.integer :votes_count, default:0

      t.integer :last_reply_user_id
      t.integer :order, default:0

      t.integer :node_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
    add_index :topics, :user_id
  end
end

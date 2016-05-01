# -*- encoding : utf-8 -*-
class CreateAttentions < ActiveRecord::Migration
  def change
    create_table :attentions do |t|

      t.integer :user_id
      t.integer :topic_id

      t.timestamps null: false
    end
    add_index :attentions, :topic_id
    add_index :attentions, :user_id
  end
end

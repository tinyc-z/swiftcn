# -*- encoding : utf-8 -*-
class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|

      t.integer :user_id
      t.integer :topic_id

      t.timestamps null: false
    end
    add_index :favorites, :topic_id
    add_index :favorites, :user_id
  end
end

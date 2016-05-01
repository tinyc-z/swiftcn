# -*- encoding : utf-8 -*-
class CreateAppends < ActiveRecord::Migration
  def change
    create_table :appends do |t|

      t.integer :topic_id
      t.text :content

      t.datetime :deleted_at
      t.timestamps null: false
    end
    add_index :appends, :topic_id
  end
end

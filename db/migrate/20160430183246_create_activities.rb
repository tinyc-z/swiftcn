class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|

      t.integer :user_id

      t.string :entity_id
      t.string :entity_type

      t.timestamps null: false
    end
    add_index :activities, :user_id
  end
end

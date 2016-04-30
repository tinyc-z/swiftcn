class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|

      t.integer :user_id

      t.string :entity_id
      t.string :entity_type

      t.timestamps null: false
    end

    add_index :activities, :user_id

    Topic.find_each do |single|
      Activity.create(user_id:single.user_id,entity_id:single.id,entity_type:"create_#{single.class.to_s.underscore}",created_at:single.created_at);
    end
    Reply.find_each do |single|
      Activity.create(user_id:single.user_id,entity_id:single.id,entity_type:"create_#{single.class.to_s.underscore}",created_at:single.created_at);
    end
    
  end
end

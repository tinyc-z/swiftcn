class CreateSiteStatuses < ActiveRecord::Migration
  def change
    create_table :site_statuses do |t|
      
      t.datetime :day_at
      
      t.integer :register_count ,default:0
      t.integer :topic_count ,default:0
      t.integer :reply_count ,default:0
      t.integer :image_count ,default:0

      t.timestamps null: false
    end
  end
end

class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      
      t.integer :user_id
      t.integer :uid

      t.string :provider, null: false
      t.string :access_token

      t.datetime :expires_at

      t.timestamps null: false
    end
    add_index :authentications, :user_id
    add_index :authentications, :uid
    add_index :authentications, :access_token
    
  end
end

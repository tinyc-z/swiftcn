class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.integer :user_id

      t.references :votable, polymorphic: true, index: true
      
      t.string :is

      t.timestamps null: false
    end

  end
end

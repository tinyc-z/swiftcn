class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|

      t.string :name
      t.string :sulg

      t.integer :parent_node 
      t.integer :topics_count, default:0

      t.integer :sort , default:0

      t.timestamps null: false
    end

    add_index :nodes, :parent_node
    add_index :nodes, :name

  end
end

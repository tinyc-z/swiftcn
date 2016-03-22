class AddSoftDeleteToNode < ActiveRecord::Migration
  def change
    add_column :Nodes, :deleted_at, :datetime
  end
end

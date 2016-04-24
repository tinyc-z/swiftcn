class AddSoftDeleteToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :deleted_at, :datetime
  end
end

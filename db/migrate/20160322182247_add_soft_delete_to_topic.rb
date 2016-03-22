class AddSoftDeleteToTopic < ActiveRecord::Migration
  def change
    add_column :Topics, :deleted_at, :datetime
  end
end

class AddUserToAppend < ActiveRecord::Migration
  def change
    add_column :appends, :user_id, :integer
  end
end

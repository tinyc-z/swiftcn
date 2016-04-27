class RenameStatFileds < ActiveRecord::Migration
  def change
    rename_column :site_statuses, :vote_up_count,:vote_count
    rename_column :site_statuses, :register_count,:user_count
    remove_column :site_statuses, :vote_down_count
  end
end

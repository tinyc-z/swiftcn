class RemoveSiteStatusImageCountToPhotoCount < ActiveRecord::Migration
  def change
    rename_column :site_statuses, :image_count, :photo_count
  end
end

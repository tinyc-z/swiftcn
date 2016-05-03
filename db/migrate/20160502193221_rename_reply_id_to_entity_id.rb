class RenameReplyIdToEntityId < ActiveRecord::Migration
  def change
    rename_column :notifications, :reply_id,:entity_id
  end
end

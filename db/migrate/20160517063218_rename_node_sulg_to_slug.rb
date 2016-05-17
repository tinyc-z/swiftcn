class RenameNodeSulgToSlug < ActiveRecord::Migration
  def change
    rename_column :nodes, :sulg, :slug
  end
end

# -*- encoding : utf-8 -*-
class RenameFieldParentNodeToParentNodeId < ActiveRecord::Migration
  def change
    rename_column :nodes, :parent_node, :parent_node_id
  end
end

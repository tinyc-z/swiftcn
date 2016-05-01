# -*- encoding : utf-8 -*-
class AddSoftDeleteToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :deleted_at, :datetime
  end
end

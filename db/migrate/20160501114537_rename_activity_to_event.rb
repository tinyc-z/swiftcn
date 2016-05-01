# -*- encoding : utf-8 -*-
class RenameActivityToEvent < ActiveRecord::Migration
  def change
     rename_table :activities, :event_logs
  end
end

class ChangeAppdenContentToSupportMarkdown < ActiveRecord::Migration
  def change
    rename_column :appends,:content,:body
    add_column :appends,:body_original,:text
  end
end

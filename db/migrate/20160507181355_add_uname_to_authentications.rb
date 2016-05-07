class AddUnameToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :uname, :string
  end
end

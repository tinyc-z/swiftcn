class AddProviderUrlToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :provider_url, :string
  end
end

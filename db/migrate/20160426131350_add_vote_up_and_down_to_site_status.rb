class AddVoteUpAndDownToSiteStatus < ActiveRecord::Migration
  def change
    add_column :site_statuses, :vote_up_count, :integer ,default:0
    add_column :site_statuses, :vote_down_count, :integer ,default:0
  end
end

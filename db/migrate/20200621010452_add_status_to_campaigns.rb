class AddStatusToCampaigns < ActiveRecord::Migration[5.2]
  def up
    add_column :campaigns, :status, :string, default: :unreviewed
  end

  def down
    remove_column :campaigns, :status
  end
end

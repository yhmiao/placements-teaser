class CreateCampaigns < ActiveRecord::Migration[5.2]
  def up
    create_table :campaigns do |t|
      t.string :name, null: false
      t.timestamps
    end
  end

  def down
    drop_table :campaigns
  end
end

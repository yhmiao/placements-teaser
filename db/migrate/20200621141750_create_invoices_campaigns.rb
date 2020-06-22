class CreateInvoicesCampaigns < ActiveRecord::Migration[5.2]
  def up
    create_table :invoices_campaigns do |t|
      t.references :invoice, index: true
      t.references :campaign, index: true
      t.timestamps
    end
  end

  def down
    drop_table :invoices_campaigns
  end
end

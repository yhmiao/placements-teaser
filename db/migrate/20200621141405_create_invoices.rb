class CreateInvoices < ActiveRecord::Migration[5.2]
  def up
    create_table :invoices do |t|
      t.string :token, null: false
      t.string :status, default: :draft, null: false
      t.timestamps
    end
  end

  def down
    drop_table :invoices
  end
end

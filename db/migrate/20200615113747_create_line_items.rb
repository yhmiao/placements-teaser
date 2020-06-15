class CreateLineItems < ActiveRecord::Migration[5.2]
  def up
    create_table :line_items do |t|
      t.references :campaign, null: false
      t.string :name, null: false
      t.decimal :booked_amount, null: false, precision: 10, scale: 15, default: 0
      t.decimal :actual_amount, null: false, precision: 10, scale: 15, default: 0
      t.decimal :adjustments, null: false, precision: 10, scale: 15, default: 0
    end
  end

  def down
    drop_table :line_items
  end
end

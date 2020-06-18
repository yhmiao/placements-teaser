class AddLockVersionToLineItems < ActiveRecord::Migration[5.2]
  def up
    add_column :line_items, :lock_version, :integer, default: 0, null: false
  end

  def down
    add_column :line_items, :lock_version
  end
end

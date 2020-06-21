class AddStatusToLineItems < ActiveRecord::Migration[5.2]
  def up
    add_column :line_items, :status, :string, default: :unreviewed
  end

  def down
    remove_column :line_items, :status
  end
end

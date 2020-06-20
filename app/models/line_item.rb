class LineItem < ApplicationRecord
  belongs_to :campaign

  SEARCHABLE = %w[line_items.name booked_amount actual_amount adjustments].freeze

  def sub_total
    actual_amount + adjustments
  end
end

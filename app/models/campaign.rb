class Campaign < ApplicationRecord
  has_many :line_items

  SEARCHABLE = 'campaigns.name'.freeze

  def line_items_count
    line_items.count
  end

  def grand_total
    line_items.sum(&:sub_total)
  end
end

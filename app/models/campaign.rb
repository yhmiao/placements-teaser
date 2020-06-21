class Campaign < ApplicationRecord
  include AASM

  SEARCHABLE = %w[campaigns.name campaigns.status].freeze
  STATUS     = %i[unreviewed reviewed].freeze

  has_many :line_items

  has_paper_trail

  aasm :status do
    state(STATUS[0], initial: true)
    state(STATUS[1])

    event :review do
      transitions from: :unreviewed, to: :reviewed, guard: -> { line_items.all?(&:reviewed?) }
    end
  end

  def line_items_count
    line_items.length
  end

  def grand_total
    line_items.sum(&:sub_total)
  end
end

class LineItem < ApplicationRecord
  include AASM

  SEARCHABLE = %w[line_items.name booked_amount actual_amount adjustments line_items.status].freeze
  STATUS     = %i[unreviewed reviewed].freeze

  belongs_to :campaign

  has_paper_trail

  aasm :status do
    state(STATUS[0], initial: true)
    state(STATUS[1])

    event(:review)  { transitions(from: :unreviewed, to: :reviewed) }
  end

  def sub_total
    actual_amount + adjustments
  end
end

class Invoice < ApplicationRecord
  include AASM
  include Tokenable

  SEARCHABLE  = %w[token invoices.status].freeze
  OK_STATUS   = %i[draft reviewed paid].freeze
  FAIL_STATUS = %i[cancelled refunded].freeze

  has_many :invoices_campaigns
  has_many :campaigns, through: :invoices_campaigns

  has_paper_trail

  aasm :status do
    state(OK_STATUS[0], initial: true)
    state(*OK_STATUS[1..-1])
    state(*FAIL_STATUS[0..-1])

    event(:review) { transitions(from: :draft, to: :reviewed) }
    event(:pay)    { transitions(from: :reviewed, to: :paid) }
    event(:cancel) { transitions(from: %i[draft reviewed], to: :cancelled) }
    event(:refund) { transitions(from: :paid, to: :refunded) }
  end

  def campaigns_count
    campaigns.length
  end

  def grand_total
    campaigns.sum(&:grand_total)
  end
end

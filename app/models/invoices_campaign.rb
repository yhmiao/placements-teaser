class InvoicesCampaign < ApplicationRecord
  belongs_to :invoice
  belongs_to :campaign
end

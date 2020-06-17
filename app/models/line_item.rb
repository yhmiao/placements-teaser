class LineItem < ApplicationRecord
  belongs_to :campaign

  def sub_total
    actual_amount + adjustments
  end
end

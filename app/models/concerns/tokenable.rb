module Tokenable
  extend ActiveSupport::Concern

  included do 
    before_create :generate_token
  end

  private

  def generate_token
    sto         = sum_to_one(self.class.name.split.map(&:ord).sum)
    token_ary   = DateTime.current.to_i.to_s.split(//).map { |d| ((d.to_i + sto) % 10).to_s }
    self.token  = token_ary.join
  end

  def sum_to_one(num)
    return num if num.to_s.length == 1
    sum_to_one(num.to_s.split(//).map(&:to_i).sum)
  end
end

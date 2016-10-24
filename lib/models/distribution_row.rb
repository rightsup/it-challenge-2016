class DistributionRow
  attr_reader :amount
  def initialize(attributes = {})
    @amount = attributes[:amount]
  end
end

class LicenseAgreement
  attr_reader :right_holder_slug,
    :owned_percentage,
    :rightsup_commission,
    :introducer_commission

  def initialize(options = {})
    @right_holder_slug = options[:right_holder_slug]
    @owned_percentage = options[:owned_percentage]
    @rightsup_commission = options[:rightsup_commission]
    @introducer_commission = options[:introducer_commission]
  end
end

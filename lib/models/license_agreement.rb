class LicenseAgreement
  attr_reader :right_holder_slug,
    :rightsup_commission,
    :introducer_commission

  def initialize(right_holder_slug, rightsup_commission, introducer_commission)
    @right_holder_slug = right_holder_slug
    @rightsup_commission = rightsup_commission
    @introducer_commission = introducer_commission
  end
end

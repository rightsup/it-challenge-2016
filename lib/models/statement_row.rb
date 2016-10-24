class StatementRow
  attr_reader :right_holder_slug,
    :right_holder_share,
    :rightsup_share,
    :ambassador_share

  def initialize(options)
    @right_holder_slug = options[:right_holder_slug]
    @right_holder_share = options[:right_holder_share]
    @rightsup_share = options[:rightsup_share]
    @ambassador_share = options[:ambassador_share]
  end
end

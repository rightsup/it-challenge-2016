require 'test_helper'
require 'services/compute_distribution'

module ComputeDistribution
  class TestSplit < Minitest::Test
    def test_split
      recording_aggreements = [
        LicenseAgreement.new(
          right_holder_slug: 'stillvortalent',
          owned_percentage: 0.50,
          rightsup_commission: 0.20
        ),
        LicenseAgreement.new(
          right_holder_slug: 'suol',
          owned_percentage: 0.50,
          rightsup_commission: 0.20
        )
      ]

      distribution_row = DistributionRow.new(amount: 100, recording_id: 12345)
      statement_rows = ComputeDistribution.distribute_row(distribution_row, recording_aggreements)

      assert_equal 2, statement_rows.size

      assert_equal 'stillvortalent', statement_rows.first.right_holder_slug
      assert_equal 40, statement_rows.first.right_holder_share
      assert_equal 10, statement_rows.first.rightsup_share

      assert_equal 'suol', statement_rows.last.right_holder_slug
      assert_equal 40, statement_rows.last.right_holder_share
      assert_equal 10, statement_rows.last.rightsup_share
    end

    def test_split_with_introducer
      recording_aggreements = [
        LicenseAgreement.new(
          right_holder_slug: 'stillvortalent',
          owned_percentage: 0.50,
          rightsup_commission: 0.20,
          introducer_commission: 0,
        ),
        LicenseAgreement.new(
          right_holder_slug: 'suol',
          owned_percentage: 0.50,
          rightsup_commission: 0.20,
          introducer_commission: 0.50,
        )
      ]

      distribution_row = DistributionRow.new(amount: 100, recording_id: 12345)
      statement_rows = ComputeDistribution.distribute_row(distribution_row, recording_aggreements)

      assert_equal 2, statement_rows.size

      assert_equal 'stillvortalent', statement_rows.first.right_holder_slug
      assert_equal 40, statement_rows.first.right_holder_share
      assert_equal 10, statement_rows.first.rightsup_share
      assert_equal 0, statement_rows.first.introducer_share

      assert_equal 'suol', statement_rows.last.right_holder_slug
      assert_equal 40, statement_rows.last.right_holder_share
      assert_equal 5, statement_rows.last.rightsup_share
      assert_equal 5, statement_rows.last.introducer_share
    end
  end
end

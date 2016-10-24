require 'test_helper'
require 'services/compute_distribution'

module ComputeDistribution
  class TestSimpleCase < Minitest::Test
    def test_simple_case
      recording_aggreements = [
        LicenseAgreement.new('stillvortalent', 100, 0)
      ]

      distribution_row = DistributionRow.new(amount: 100, recording_id: 12345)
      statement_rows = ComputeDistribution.distribute_row(distribution_row)

      assert_equal 1, statement_rows.size

      assert_equal 'stillvortalent', statement_rows.first.right_holder_slug
      assert_equal 100, statement_rows.first.right_holder_share
      assert_equal 20, statement_rows.first.rightsup_share
      assert_equal 0, statement_rows.first.ambassador_share
    end
  end
end

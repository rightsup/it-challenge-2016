require 'test_helper'
require 'services/compute_distribution'

module ComputeDistribution
  class TestSplit < Minitest::Test
    def test_split_with_introducer
      recording_aggreements = [
        LicenseAgreement.new('stillvortalent', 20, 0),
        LicenseAgreement.new('suol', 20, 50)
      ]

      distribution_row = DistributionRow.new(amount: 100, recording_id: 12345)
      statement_rows = ComputeDistribution.distribute_row(distribution_row)

      assert_equal 2, statement_rows.size

      assert_equal 'stillvortalent', statement_rows.first.right_holder_slug
      assert_equal 40, statement_rows.first.right_holder_share
      assert_equal 10, statement_rows.first.rightsup_share
      assert_equal 0, statement_rows.first.ambassador_share

      assert_equal 'suol', statement_rows.last.right_holder_slug
      assert_equal 40, statement_rows.last.right_holder_share
      assert_equal 5, statement_rows.last.rightsup_share
      assert_equal 5, statement_rows.last.ambassador_share
    end
  end
end

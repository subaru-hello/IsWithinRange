# frozen_string_literal: true

require 'test/unit'
require './target_time_check'

class TestTargetTimeCheck < Test::Unit::TestCase
  def setup
    @target_within_start_finish = TargetTimeCheck.new(2, 1, 0)
    @target_same_with_start = TargetTimeCheck.new(1, 0, 1)
    @target_same_with_finish = TargetTimeCheck.new(0, 1, 1)
    @target_same_with_all = TargetTimeCheck.new(1, 1, 1)
    @target_out_of_range_start_finish = TargetTimeCheck.new(23, 5, 6)
  end



  def test_included
    assert_equal('含まれます', @target_within_start_finish.included?)
    assert_equal('含まれます', @target_same_with_start.included?)
    assert_equal('含まれます', @target_same_with_all.included?)
  end

  def test_not_included
    assert_equal('含まれません', @target_same_with_finish.included?)
    assert_equal('含まれません', @target_out_of_range_start_finish.included?)
  end
end

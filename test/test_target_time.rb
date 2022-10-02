# frozen_string_literal: true

require 'test/unit'
require './time'

class TestTime < Test::Unit::TestCase
  def setup
    @target_within_start_finish = Time.new(2, 1, 0)
    @target_same_with_start = Time.new(1, 0, 1)
    @target_same_with_finish = Time.new(0, 1, 1)
    @target_same_with_all = Time.new(1, 1, 1)
    @target_out_of_range_start_finish = Time.new(23, 5, 6)
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

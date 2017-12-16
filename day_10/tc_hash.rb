require_relative "hash"
require "test/unit"

class TestHash < Test::Unit::TestCase

    def test_reverse_segment
        assert_equal([2,1,0,3,4], reverse_segment([0,1,2,3,4], 3, 0) )
        assert_equal([4,3,0,1,2], reverse_segment([2,1,0,3,4], 4, 3) )
        assert_equal([4,3,0,1,2], reverse_segment([4,3,0,1,2], 1, 3) )
        assert_equal([3,4,2,1,0], reverse_segment([4,3,0,1,2], 5, 1) )
    end

    def test_solve_chain
        assert_equal(12, calculate_chain((0..4).to_a, [3,4,1,5]))
        assert_equal(9656, calculate_chain((0..255).to_a, [206,63,255,131,65,80,238,157,254,24,133,2,16,0,1,3]))
    end
end
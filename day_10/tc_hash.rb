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

    def test_converting_ascii_to_byte_array
        assert_equal( [49,44,50,44,51], convert_ascii_to_byte_array("1,2,3"))
    end

    def test_calculating_hash
        assert_equal( "a2582a3a0e66e6e86e3812dcb672a272", calculate_hash(""))
        assert_equal( "20b7b54c92bf73cf3e5631458a715149", calculate_hash("206,63,255,131,65,80,238,157,254,24,133,2,16,0,1,3"))

    end

    def test_creating_hash_from_16_bytes
        assert_equal( 64, create_sparse_hash([65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22]))
    end
end
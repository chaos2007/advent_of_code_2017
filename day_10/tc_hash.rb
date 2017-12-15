require_relative "hash"
require "test/unit"

class TestHash < Test::Unit::TestCase

    def test_simple
        assert_equal(0, Hash.new.test )
    end
end
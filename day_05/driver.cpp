#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch.hpp"
#include <algorithm>
#include <vector>
#include <string>
#include <iostream>
#include <iterator>
#include <fstream>

int32_t convert_integer(std::string number) {
    std::string::size_type sz;
    return std::stoi(number, &sz);
}

auto how_many_steps(std::vector<std::string> jumps) {
    std::vector<std::int32_t> converted_jumps;
    converted_jumps.resize(jumps.size());
    std::transform(jumps.begin(), jumps.end(), converted_jumps.begin(), convert_integer);

    auto num_steps = 0;
    auto index_number = 0;
    while( index_number >= 0 and index_number < converted_jumps.size()) {
        converted_jumps[index_number]++;
        index_number+= converted_jumps[index_number] - 1;
        num_steps++;
    }
    return num_steps;
}

auto how_many_steps_2(std::vector<std::string> jumps) {
    std::vector<std::int32_t> converted_jumps;
    converted_jumps.resize(jumps.size());
    std::transform(jumps.begin(), jumps.end(), converted_jumps.begin(), convert_integer);

    auto num_steps = 0;
    auto index_number = 0;
    while( index_number >= 0 and index_number < converted_jumps.size()) {
        auto offset = converted_jumps[index_number];
        (offset >= 3) ? converted_jumps[index_number]-- : converted_jumps[index_number]++;
        index_number+= offset;
        num_steps++;
    }
    return num_steps;
}

TEST_CASE( "Jump example works correctly.", "[test_input]" ) {
    std::vector<std::string> jumps = {"0", "3", "0", "1", "-3"};
    REQUIRE( 5 == how_many_steps(jumps));
    REQUIRE( 10 == how_many_steps_2(jumps));

    std::vector<std::string> myLines;
    std::ifstream myfile("part1.txt"); 
    std::copy(std::istream_iterator<std::string>(myfile),
          std::istream_iterator<std::string>(),
          std::back_inserter(myLines));
    REQUIRE( 388611 == how_many_steps(myLines));
    REQUIRE( 27763113 == how_many_steps_2(myLines));
}
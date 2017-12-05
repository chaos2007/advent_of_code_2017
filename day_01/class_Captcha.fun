test_suite class_Captcha

setup
end setup

teardown
end teardown

test test_simple_sum
    assert_equal(3, parse_line("1122"))
end test

test test_all_repeating
    assert_equal(4, parse_line("1111"))
end test

test test_no_matches
    assert_equal(0, parse_line("1234"))
end test

test test_wrap
    assert_equal(9, parse_line("91212129"))
end test

test test_simple_2
    assert_equal(6, parse_line_2("1212"))
end test

test test_none_2
    assert_equal(0, parse_line_2("1221"))
end test

test test_one_2
    assert_equal(4, parse_line_2("123425"))
end test

test test_multiple_2
    assert_equal(12, parse_line_2("123123"))
end test

test test_more_multiple_2
    assert_equal(4, parse_line_2("12131415"))
end test

end test_suite 



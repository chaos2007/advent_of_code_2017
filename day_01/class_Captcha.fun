test_suite class_Captcha

setup
end setup

teardown
end teardown

test test_simple_sum
    type(Captcha) :: k
    call parse_line(k, "1122")
    assert_equal(3, get_current_value(k))
end test

test test_all_repeating
    type(Captcha) :: k
    call parse_line(k, "1111")
    assert_equal(4, get_current_value(k))
end test

test test_no_matches
    type(Captcha) :: k
    call parse_line(k, "1234")
    assert_equal(0, get_current_value(k))
end test

test test_wrap
    type(Captcha) :: k
    call parse_line(k, "91212129")
    assert_equal(9, get_current_value(k))

end test_suite 



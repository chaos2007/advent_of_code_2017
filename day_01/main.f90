program main
    use class_Captcha
    implicit none

    type(Captcha) :: k
    k = Captcha()
    Print *, "Part 1."
    call parse_line(k, "")
    Print *, "Answer: ", get_current_value(k)

end program


module class_Captcha
    implicit none
    public :: Captcha, get_current_value, parse_line
    
    type Captcha
    end type Captcha

    contains
        function get_current_value(this) result(key)
            type(Captcha), intent(in) :: this
            integer :: key
            key = 0
        end function get_current_value

        subroutine parse_line(this, line)
            type(Captcha), intent(inout) :: this
            character(len=*) :: line
            integer :: n
            do n = 1, len(line(:)) 
            end do
        end subroutine
end module class_Captcha


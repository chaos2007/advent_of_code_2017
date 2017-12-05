module class_Captcha
    implicit none
    public :: parse_line

    contains

        integer function parse_line(line) result(retVal)
            implicit none
            character(len=*) :: line
            integer :: acc, i, length, second_index
            character :: first, second
            retVal = 0
            length = len(line(:))

            do i = 1, length
                first = line(i:i)
                second_index = mod(i, length) + 1 
                second = line(second_index:second_index)
                if ( first .eq. second ) then
                    retVal = retVal + ichar(first) - 48
                end if
            end do
        end function

        integer function parse_line_2(line) result(retVal)
            implicit none
            character(len=*) :: line
            integer :: acc, i, length, second_index
            character :: first, second
            retVal = 0
            length = len(line(:))

            do i = 1, length
                first = line(i:i)
                second_index = mod(i+length/2 - 1, length) + 1
                second = line(second_index:second_index)
                if ( first .eq. second ) then
                    retVal = retVal + ichar(first) - 48
                end if
            end do
        end function

end module class_Captcha


program test_assert_subroutine_error_termination
  !! Test "assert" subroutine calls that are intended to error terminate
  use assert_m, only : assert
  implicit none
  
  integer exit_status

  print *
  print *,"The assert subroutine"
  call execute_command_line( &
    command = "fpm run --example intentionally_false_assertions > /dev/null 2>&1", &
    wait = .true., &
    exitstat = exit_status &
  )
    
  block
    logical error_termination

    error_termination = exit_status /=0
#ifndef __flang__
    call co_all(error_termination)

    if (this_image()==1) then
#endif
      if (error_termination) then
        print *,"  passes on error-terminating when assertion = .false."
      else 
        print *,"  FAILS to error-terminate when assertion = .false. (Yikes! Who designed this OS?)"
      end if
#ifndef __flang__
    end if
#endif
  end block

contains

  pure function and_operation(lhs,rhs) result(lhs_and_rhs)
    logical, intent(in) :: lhs, rhs
    logical lhs_and_rhs
    lhs_and_rhs = lhs .and. rhs
  end function

#ifndef __flang__
  subroutine co_all(boolean)
    logical, intent(inout) :: boolean
    call co_reduce(boolean, and_operation)
  end subroutine
#endif

end program test_assert_subroutine_error_termination

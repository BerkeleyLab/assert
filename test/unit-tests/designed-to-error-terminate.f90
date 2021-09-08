program designed_to_error_terminate
  !! Test assertions that are intended to error terminate
  use assert_m, only : assert
  implicit none
  
  integer exit_status

  call execute_command_line( &
    command = "fpm run --example intentionally_false_assertions > /dev/null 2>&1", &
    wait = .true., &
    exitstat = exit_status &
  )
    
  block
    logical error_termination

    error_termination = exit_status /=0

    call co_all(error_termination)

    if (this_image()==1) then

      if (error_termination) then
        print *, "----> All tests designed to error-terminate pass.    <----"
      else 
        print *, "----> One or more tests designed to error-terminate terminated normally. Yikes! Who designed this OS? <----"
      end if

    end if

  end block

contains

  pure function both(lhs,rhs) result(lhs_or_rhs)
    logical, intent(in) :: lhs,rhs
    logical lhs_or_rhs

    lhs_or_rhs = lhs .and. rhs

  end function

  subroutine co_all(boolean)
    logical, intent(inout) :: boolean

#ifndef NAGFOR
    call co_reduce(boolean, both)
#else
    ! Because parallel NAG runs happen in shared memory and because this function is called only once in 
    ! one test, a simplistic, non-scalable reduction algorithm suffices until co_reduce is supported.
    block
      logical, save :: my_boolean[*]
      integer i

      my_boolean = boolean
      do i=1,num_images()
        my_boolean = my_boolean .and.  my_boolean[i]
      end do
    end block
#endif

  end subroutine

end program

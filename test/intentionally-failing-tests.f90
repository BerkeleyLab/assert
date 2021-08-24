program tests_designed_to_fail
  !! Test assertions intended to error terminate
  use assert_m, only : assert
  implicit none
  
  integer exit_status

  call execute_command_line( &
    command = "fpm run --example tests_designed_to_fail", &
    wait = .true., &
    exitstat = exit_status )

  sync all
  
  if (exit_status == 0) then
    print *,new_line('a'), "tests_designed_to_fail: yikes! The unit tests designed to fail actually pass.", new_line('a')
  else 
    print *, new_line('a'), "tests_designed_to_fail: failing as intended.", new_line('a')
  end if

end program

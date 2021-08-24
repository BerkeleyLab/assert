program designed_to_error_terminate
  !! Test assertions intended that are intended to error terminate
  use assert_m, only : assert
  implicit none
  
  integer exit_status

  call execute_command_line( &
    command = "fpm run --example intentionally_false_assertions", &
    wait = .true., &
    exitstat = exit_status )

  sync all
  
  if (exit_status == 0) then
    print *,new_line(''), "designed-to-error-terminate: Yikes! Normal termination detected.  Who designed this OS?", new_line('')
  else 
    print *,new_line(''), "----> designed-to-error-terminate: The unit tests designed to error-terminate do so. <----", new_line('')
  end if

end program

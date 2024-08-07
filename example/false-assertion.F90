program false_assertion
  use assert_m, only : assert
  implicit none

  call assert(.false., "false-assertion: unconditionally failing test")

end program

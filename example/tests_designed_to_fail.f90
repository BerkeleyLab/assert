program main
  use assert_m, only : assert
  implicit none

  call assert(.false., "main: unconditionally failing test")

end program main

program assertion_examples
  !! Demonstrate the use of assertions
  use assert_m, only : assert
  implicit none
  integer, parameter :: i = 1
  real, parameter :: x = -1.
  
  call assert(i > 0, "i > 1") ! Passes
  call assert(x > 0, description="x > 0", diagnostic_data=x) ! Fails with output containing diagnostic data
end program

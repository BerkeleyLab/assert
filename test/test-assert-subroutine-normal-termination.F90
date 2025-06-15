#include "assert_features.h"

program test_assert_subroutine_normal_termination
  !! Test direct calls to the "assert" subroutine that don't error-terminate
  use assert_m, only : assert
  implicit none

  print *
  print *,"The assert subroutine"

  call assert(assertion = .true., description = "3 keyword arguments ")
  call assert(            .true., description = "2 keyword arguments ")
  call assert(            .true.,               "no optional argument")
#if ASSERT_MULTI_IMAGE
    sync all
    if (this_image()==1) &
#endif
    print *,"  passes on not error-terminating when assertion=.true."
  
end program

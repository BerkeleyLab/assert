#include "assert_features.h"

program test_assert_subroutine_normal_termination
  !! Test direct calls to the "assert" subroutine that don't error-terminate
  use assert_m, only : assert
  implicit none

#if ASSERT_MULTI_IMAGE
  if (this_image()==1) then
#endif
    print *, new_line(''), "The assert subroutine"
#if ASSERT_MULTI_IMAGE
  end if
  sync all
#endif

  call assert(assertion = .true., description = "2 keyword arguments")
  call assert(            .true., description = "1 keyword arguments")
  call assert(            .true.,               "0 keyword arguments")

#if ASSERT_MULTI_IMAGE
  sync all
  if (this_image()==1) then
#endif
    print *,"  passes on not error-terminating when assertion=.true."
#if ASSERT_MULTI_IMAGE
  end if
#endif
  
end program

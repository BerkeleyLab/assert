program test_assert_macros
  use assert_m
  implicit none

  print *
  print *,"The call_assert macro"

#define DEBUG
#include "assert_macros.h"
  call_assert(1==1)
  print *,"  passes on not error-terminating when an assertion expression evaluating to .true. is the only argument"

#undef DEBUG
#include "assert_macros.h"
  call_assert(.false.)
  print *,"  passes on being removed by the preprocessor when DEBUG is undefined" // new_line('')

  !------------------------------------------

  print *,"The call_assert_describe macro"

#define DEBUG
#include "assert_macros.h"
  call_assert_describe(.true., ".true.")
  print *,"  passes on not error-terminating when assertion = .true. and a description is present"

#undef DEBUG
#include "assert_macros.h"
  call_assert_describe(.false., "")
  print *,"  passes on being removed by the preprocessor when DEBUG is undefined" // new_line('')

  !------------------------------------------

  print *,"The call_assert_diagnose macro"

#define DEBUG
#include "assert_macros.h"
  call_assert_diagnose(.true., ".true.", diagnostic_data=1)
  print *,"  passes on not error-terminating when assertion = .true. and description and diagnostic_data are present"

#undef DEBUG
#include "assert_macros.h"
  call_assert_describe(.false., "")
  print *,"  passes on being removed by the preprocessor when DEBUG is undefined"

end program

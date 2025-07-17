program test_assert_macros
  use assert_m
  implicit none

  print *
  print '(a)',"The call_assert macro"

#undef ASSERTIONS
#define ASSERTIONS 1
#include "assert_macros.h"
  call_assert(1==1)
  print '(a)',"  passes on not error-terminating when an assertion expression evaluating to .true. is the only argument"

#undef ASSERTIONS
#include "assert_macros.h"
  call_assert(.false.)
  print '(a)',"  passes on being removed by the preprocessor when ASSERTIONS is undefined" // new_line('')

  !------------------------------------------

  print '(a)',"The call_assert_describe macro"

#undef ASSERTIONS
#define ASSERTIONS 1
#include "assert_macros.h"
  call_assert_describe(.true., ".true.")
  print '(a)',"  passes on not error-terminating when assertion = .true. and a description is present"

#undef ASSERTIONS
#include "assert_macros.h"
  call_assert_describe(.false., "")
  print '(a)',"  passes on being removed by the preprocessor when ASSERTIONS is undefined" // new_line('')

  !------------------------------------------

#undef ASSERTIONS
#define ASSERTIONS 1
#include "assert_macros.h"
  print '(a)',"The call_assert_* macros"
  block
    logical :: foo
    foo = check_assert(.true.)
    print '(a)',"  pass on invocation from a pure function"
  end block

  !------------------------------------------
#undef ASSERTIONS
#define ASSERTIONS 1
#include "assert_macros.h"

  ! The following examples are taken from README.md and should be kept in sync with that document:
  block
  integer :: computed_checksum = 37, expected_checksum = 37

#if defined(_CRAYFTN)
  ! Cray Fortran uses different line continuations in macro invocations
  call_assert_describe( computed_checksum == expected_checksum, &
                      "Checksum mismatch failure!" &
                      )                      
  print *,"  passes with line breaks inside macro invocation"

  call_assert_describe( computed_checksum == expected_checksum, & ! ensured since version 3.14
                        "Checksum mismatch failure!"            & ! TODO: write a better message here 
                      )
  print *,"  passes with C block comments embedded in macro invocation"
#else
  call_assert_describe( computed_checksum == expected_checksum, \
                        "Checksum mismatch failure!" \
                      )
  print *,"  passes with line breaks inside macro invocation"

  call_assert_describe( computed_checksum == expected_checksum, /* ensured since version 3.14 */ \
                        "Checksum mismatch failure!"            /* TODO: write a better message here */ \
                      )
  print *,"  passes with C block comments embedded in macro invocation"
#endif

  end block
  !------------------------------------------

contains 

  pure function check_assert(cond) result(ok)
    logical, intent(in) :: cond
    logical ok

    call_assert(cond)
    call_assert_describe(cond, "check_assert")

    ok = .true.
  end function

end program

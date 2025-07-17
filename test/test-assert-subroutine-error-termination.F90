#include "assert_features.h"

program test_assert_subroutine_error_termination
  !! Test "assert" subroutine calls that are intended to error terminate
  use assert_m, only : assert
  implicit none
  
  integer exit_status

#if ASSERT_MULTI_IMAGE
  if (this_image()==1) then
#endif

    print *, new_line(''), "The assert subroutine"

#if ASSERT_MULTI_IMAGE
  end if
#endif

  ! TODO: The following is a HORRIBLY fragile test. 
  ! Specifically, it encodes a bunch of compiler-specific flags into an fpm command, 
  ! and if fpm fails for any unrelated reason (broken command, compile error, I/O error, etc)
  ! we will mistakenly interpret that as a passing test!

  call execute_command_line( &
#ifdef __GFORTRAN__
    command = "fpm run --example false-assertion --profile release --flag '-DASSERTIONS -ffree-line-length-0' > /dev/null 2>&1", &
#elif NAGFOR
    command = "fpm run --example false-assertion --compiler nagfor --flag '-DASSERTIONS -fpp' > /dev/null 2>&1", &
#elif __flang__
    command = "./test/run-false-assertion.sh", &
#   define RESULT_FROM_FILE 1
#elif __INTEL_COMPILER
    command = "./test/run-false-assertion-intel.sh", &
#   define RESULT_FROM_FILE 1
#elif _CRAYFTN
    command = "fpm run --example false-assertion --profile release --compiler crayftn.sh --flag '-DASSERTIONS' > /dev/null 2>&1", &
#elif __LFORTRAN__
    command = "fpm run --example false-assertion --profile release --flag '-DASSERTIONS -ffree-line-length-0' > /dev/null 2>&1", &
#else
    ! All other compilers need their command manually validated and added to the list above
    command = "echo 'example/false_assertion.F90: unsupported compiler' && exit 1", &
#endif
    wait = .true., &
    exitstat = exit_status &
  )

#if RESULT_FROM_FILE
  ! some compilers don't provide a reliable exitstat for the command above, 
  ! so for those we write it to a file and retrieve it here
  block
      integer unit
      open(newunit=unit, file="build/exit_status", status="old")
      read(unit,*) exit_status
      close(unit)
  end block 
#endif

#if ASSERT_MULTI_IMAGE
  exit_status = abs(exit_status)
  call co_max(exit_status)
  if (this_image()==1) then
    print *,trim(merge("passes","FAILS ",exit_status/=0)) // " on error-terminating when assertion = .false."
  end if
#else
    print *,trim(merge("passes","FAILS ",exit_status/=0)) // " on error-terminating when assertion = .false."
#endif

end program test_assert_subroutine_error_termination

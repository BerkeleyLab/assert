#include "assert_macros.h"

program invoke_via_macro
  !! Demonstrate how to invoke the 'assert' subroutine using a preprocessor macro that facilitates
  !! the complete removal of the call in the absence of the compiler flag -DDEBUG.
  use assert_m, only : assert, intrinsic_array_t, string
    !! If an "only" clause is employed as above, it must include the "string" function that the
    !! call_assert* macros reference when transforming the code below into "assert" subroutine calls.
  implicit none

#ifndef DEBUG
  print *
  print *,'To enable the "assert" call, define -DDEBUG, e.g., fpm run --example invoke-via-macro --flag "-DDEBUG -fcoarray=single"'
  print *
#endif

  ! The C preprocessor will convert each call_assert* macro below into calls to the "assert" subroutine 
  ! (if -DDEBUG is in the compiler command) or into nothing (if -DDEBUG is not in the compiler command).

  call_assert(1==1) ! true assertion
  call_assert_describe(2>0,    "example assertion invocation via macro") ! true assertion
  call_assert_diagnose(1+1==2, "example with scalar diagnostic data", 1+1) ! true assertion
  call_assert_diagnose(1+1>2,  "example with array diagnostic data" , intrinsic_array_t([1,1,2])) ! false assertion

end program invoke_via_macro

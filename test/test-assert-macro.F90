program test_assert_macros
  use assert_m
  implicit none

  print *,"The call_assert macro"

#define DEBUG
#include "../../src/assert/assert_macros.h"
  call_assert(1==1)
  print *,"  passes on excecuting silently given a true assertion expression (1==1) actual argument'"

#undef DEBUG
#include "../../src/assert/assert_macros.h"
  call_assert(.false.)
  print *,"  passes on eliminating itself when DEBUG is undefined" // new_line('')

  !------------------------------------------

  print *,"The call_assert_describe macro"

#define DEBUG
#include "../../src/assert/assert_macros.h"
  call_assert_describe(.true., ".true.")
  print *,"  passes on executing silently when the arguments are a literal constant assertion (.true.) and a description"

#undef DEBUG
#include "../../src/assert/assert_macros.h"
  call_assert_describe(.false., "")
  print *,"  passes on eliminating itself when DEBUG is undefined" // new_line('')

  !------------------------------------------

  print *,"The call_assert_diagnose macro"

#define DEBUG
#include "../../src/assert/assert_macros.h"
  call_assert_diagnose(.true., ".true.", diagnostic_data=1)
  print *,"  passes executing silently when the arugments are a literal constant assertion, a description, and diagnostic data"

#undef DEBUG
#include "../../src/assert/assert_macros.h"
  call_assert_describe(.false., "")
  print *,"  passes on eliminating itself when DEBUG is undefined" // new_line('')

end program

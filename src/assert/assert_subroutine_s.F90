!
!     (c) 2019-2020 Guide Star Engineering, LLC
!     This Software was developed for the US Nuclear Regulatory Commission (US NRC) under contract
!     "Multi-Dimensional Physics Implementation into Fuel Analysis under Steady-state and Transients (FAST)",
!     contract # NRC-HQ-60-17-C-0007
!

#include "assert_features.h"

submodule(assert_subroutine_m) assert_subroutine_s
  implicit none

contains

  module procedure assert

    toggle_assertions: &
    if (enforce_assertions) then
        call assert_always(assertion, description)
    end if toggle_assertions
    
  end procedure

  module procedure assert_always
    character(len=:), allocatable :: message
    integer me

      check_assertion: &
      if (.not. assertion) then

#if ASSERT_MULTI_IMAGE
#  if ASSERT_PARALLEL_CALLBACKS
        me = assert_this_image()
#  else
        me = this_image()
#  endif
        message = 'Assertion failure on image ' // string(me) // ':' // description 
#else
        message = 'Assertion failure: ' // description
        me = 0 ! avoid a harmless warning
#endif
 
#if ASSERT_PARALLEL_CALLBACKS
        call assert_error_stop(message)
#else
        error stop message, QUIET=.false.
#endif

      end if check_assertion

  contains
    
    pure function string(numeric) result(number_as_string)
      !! Result is a string represention of the numeric argument
      class(*), intent(in) :: numeric
      integer, parameter :: max_len=128
      character(len=max_len) :: untrimmed_string
      character(len=:), allocatable :: number_as_string

      select type(numeric)
        type is(complex)
          write(untrimmed_string, *) numeric
        type is(integer)
          write(untrimmed_string, *) numeric
        type is(logical)
          write(untrimmed_string, *) numeric
        type is(real)
          write(untrimmed_string, *) numeric
        class default
          error stop "Internal error in subroutine 'assert': unsupported type in function 'string'."
      end select

      number_as_string = trim(adjustl(untrimmed_string))

    end function string

  end procedure

end submodule assert_subroutine_s

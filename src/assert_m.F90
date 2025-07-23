!     (c) 2024-2025 UC Regents, see LICENSE file for detailed terms.
!
!     (c) 2019-2020 Guide Star Engineering, LLC
!     This Software was developed for the US Nuclear Regulatory Commission (US NRC) under contract
!     "Multi-Dimensional Physics Implementation into Fuel Analysis under Steady-state and Transients (FAST)",
!     contract # NRC-HQ-60-17-C-0007
!
#include "assert_macros.h"

#include "assert_features.h"

module assert_m
  !! summary: Utility for runtime enforcement of logical assertions.
  !! usage: error-terminate if the assertion fails:
  !!
  !!    use assertions_m, only : assert
  !!    call assert( 2 > 1, "2 > 1")
  !!
  !! Assertion enforcement is controlled via the `ASSERTIONS` preprocessor macro,
  !! which can be defined to non-zero or zero at compilation time to
  !! respectively enable or disable runtime assertion enforcement.
  !!
  !! When the `ASSERTIONS` preprocessor macro is not defined to any value,
  !! the default is that assertions are *disabled* and will not check the condition.
  !!
  !! Disabling assertion enforcement may eliminate any associated runtime
  !! overhead by enabling optimizing compilers to ignore the assertion procedure
  !! body during a dead-code-removal phase of optimization.
  !!
  !! To enable assertion enforcement (e.g., for a debug build), define the preprocessor ASSERTIONS to non-zero.
  !! This file's capitalized .F90 extension causes most Fortran compilers to preprocess this file so
  !! that building as follows enables assertion enforcement: 
  !!
  !!    fpm build --flag "-DASSERTIONS"
  !!
  implicit none
  private
  public :: assert, assert_always

#if ASSERT_PARALLEL_CALLBACKS
    public :: assert_this_image_interface, assert_this_image
    public :: assert_error_stop_interface, assert_error_stop

    abstract interface
      pure function assert_this_image_interface() result(this_image_id)
        implicit none
        integer :: this_image_id
      end function
    end interface
    procedure(assert_this_image_interface), pointer :: assert_this_image
    
    abstract interface
      pure subroutine assert_error_stop_interface(stop_code_char)
        implicit none
        character(len=*), intent(in) :: stop_code_char
      end subroutine
    end interface
    procedure(assert_error_stop_interface), pointer :: assert_error_stop

#endif

#ifndef USE_ASSERTIONS
#  if ASSERTIONS
#    define USE_ASSERTIONS .true.
#  else
#    define USE_ASSERTIONS .false.
#  endif
#endif
  logical, parameter :: enforce_assertions=USE_ASSERTIONS


contains

    pure subroutine assert(assertion, description)
      !! If assertion is .false. and enforcement is enabled (e.g. via -DASSERTIONS=1),
      !! then error-terminate with a character stop code that contains the description argument if present
      implicit none
      logical, intent(in) :: assertion
        !! Most assertions will be expressions such as i>0
      character(len=*), intent(in) :: description
        !! A brief statement of what is being asserted such as "i>0" or "positive i"

    toggle_assertions: &
    if (enforce_assertions) then
        call assert_always(assertion, description)
    end if toggle_assertions
    
  end subroutine

    pure subroutine assert_always(assertion, description, file, line)
      !! Same as above but always enforces the assertion (regardless of ASSERTIONS)
      implicit none
      logical, intent(in) :: assertion
      character(len=*), intent(in) :: description
      character(len=*), intent(in), optional :: file
      integer, intent(in), optional :: line
    character(len=:), allocatable :: message
    character(len=:), allocatable :: location
    integer me

      check_assertion: &
      if (.not. assertion) then
        ! Avoid harmless warnings from Cray Fortran:
        allocate(character(len=0)::message)
        allocate(character(len=0)::location)


        ! format source location, if known
        location = ''
        if (present(file)) then
          location = ' at ' // file // ':'
          if (present(line)) then ! only print line number if file is also known
            block
              character(len=128) line_str
              write(line_str, '(i0)') line
              location = location // trim(adjustl(line_str))
            end block
          else
            location = location // '<unknown>'
          endif
        endif

#if ASSERT_MULTI_IMAGE
#  if ASSERT_PARALLEL_CALLBACKS
        if (associated(assert_this_image)) then
          me = assert_this_image()
        else
          me = 0
        endif
#  else
        me = this_image()
#  endif
   block
        character(len=128) image_number
        write(image_number, *) me
        message = 'Assertion failure on image ' // trim(adjustl(image_number)) // location // ': ' // description
   end block
#else
        message = 'Assertion failure' // location // ': ' // description
        me = 0 ! avoid a harmless warning
#endif
 
#if ASSERT_PARALLEL_CALLBACKS
        if (associated(assert_this_image)) then
          call assert_error_stop(message)
        else
          ; ! deliberate fall-thru
        endif
#endif
#ifdef __LFORTRAN__
        ! workaround a defect observed in LFortran 0.54:
        ! error stop with an allocatable character argument prints garbage
        error stop message//'', QUIET=.false.
#else
        error stop message, QUIET=.false.
#endif

      end if check_assertion

  end subroutine

end module assert_m


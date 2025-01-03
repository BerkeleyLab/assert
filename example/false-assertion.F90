program false_assertion
  use assert_m
  implicit none

#if ASSERT_PARALLEL_CALLBACKS
  assert_this_image => assert_callback_this_image
  assert_error_stop => assert_callback_error_stop
#endif

  call assert(.false., "false-assertion: unconditionally failing test")

#if ASSERT_PARALLEL_CALLBACKS
! By default, assert uses `THIS_IMAGE()` in multi-image mode while
! composing assertion output, and invokes `ERROR STOP` to print the 
! assertion and terminate execution.
! 
! The ASSERT_PARALLEL_CALLBACKS preprocessor flag enables the client to replace
! the default use of these two Fortran features with client-provided callbacks. 
! To use this feature, the client must build the library with `-DASSERT_PARALLEL_CALLBACKS`,
! and then at startup set the `assert_this_image` and `assert_error_stop`
! procedure pointers to reference the desired callbacks.
contains
  
  pure function assert_callback_this_image() result(this_image_id)
    implicit none
    integer :: this_image_id
    
    this_image_id = 42
  end function
  
  pure subroutine assert_callback_error_stop(stop_code_char)
    implicit none
    character(len=*), intent(in) :: stop_code_char

    error stop "Hello from assert_callback_error_stop!" // NEW_LINE('a') // &
               "Your assertion: " // NEW_LINE('a') // stop_code_char
  end subroutine 
#endif

end program

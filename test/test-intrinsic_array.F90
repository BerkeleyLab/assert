program test_intrinsinc_array_t
  !! Test direct intrinsic_array_t derive type construction and conversion to srings
  use intrinsic_array_m, only : intrinsic_array_t
  implicit none

  character(len=:), allocatable :: passes
  integer, parameter :: max_length = 128
  character(len=max_length) array_as_string
  type(intrinsic_array_t) integer_1D, integer_2D
  print *
  print *,"An intrinsic_array_t object"

  integer_1D = intrinsic_array_t([0])
  passes = trim(merge("passes", "FAILS ", integer_1D%as_character() == "0"))
#ifndef __flang__
  sync all
  if (this_image()==1) &
#endif
  print *, "  " // passes //  " on construction from a 1D integer and converting to a string"
  
  block
    integer integer_2D_array(2,2), integer_2D_check(2,2)
    integer_2D_array = reshape([0,0,0,0], shape(integer_2D_array))
    integer_2D = intrinsic_array_t(integer_2D_array)
    write(array_as_string,*) integer_2D%as_character()
    read(array_as_string,*) integer_2D_check
    passes = trim(merge("passes", "FAILS ", all(integer_2D_array == integer_2D_check)))
#ifndef __flang__
    sync all
    if (this_image()==1) &
#endif
    print *, "  " // passes //  " on construction from a 2D integer and converting to a string"
  end block
  
end program test_intrinsinc_array_t

module intrinsic_array_m
  !! Define an abstract class that supports object representation in character form
  use characterizable_m, only : characterizable_t
  implicit none

  private
  public :: intrinsic_array_t

  type, extends(characterizable_t) :: intrinsic_array_t
    complex, allocatable :: c(:)
    integer, allocatable :: i(:)
    logical, allocatable :: l(:)
    real, allocatable :: r(:)
  contains
    procedure :: as_character
  end type

  interface intrinsic_array_t
    
    pure module function construct(array) result(intrinsic_array)
      implicit none
      class(*), intent(in) :: array(..)
      type(intrinsic_array_t) intrinsic_array
    end function
    
  end interface

  interface
    
    pure module function as_character(self) result(character_self)
      implicit none
      class(intrinsic_array_t), intent(in) :: self
      character(len=:), allocatable :: character_self
    end function
    
  end interface

end module intrinsic_array_m

module characterizable_array_m
  !! Define an abstract class that supports object representation in character form
  use characterizable_m, only : characterizable_t
  implicit none

  private
  public :: characterizable_array_t

  type, extends(characterizable_t) :: characterizable_array_t
    complex, allocatable :: c(:)
    integer, allocatable :: i(:)
    logical, allocatable :: l(:)
    real, allocatable :: r(:)
  contains
    procedure :: as_character
  end type

  interface characterizable_array_t
    
    pure module function construct(array) result(characterizable_array)
      implicit none
      class(*), intent(in) :: array(..)
      type(characterizable_array_t) characterizable_array
    end function
    
  end interface

  interface
    
    pure module function as_character(self) result(character_self)
      implicit none
      class(characterizable_array_t), intent(in) :: self
      character(len=:), allocatable :: character_self
    end function
    
  end interface

end module characterizable_array_m

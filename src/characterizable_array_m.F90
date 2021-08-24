module characterizable_array_m
  !! Define an abstract class that supports object representation in character form
  use characterizable_m, only : characterizable_t
  implicit none

  private
  public :: characterizable_array_t

  type, extends(characterizable_t) :: characterizable_array_t
    integer, allocatable :: a(:)
  contains
    procedure :: as_character
  end type

  interface characterizable_array_t
    
    pure module function characterizable_integer_array(array) result(characterizable_array)
      implicit none
#ifdef __GFORTRAN__
      integer, dimension(:), intent(in) :: array
#else
      integer, dimension(*), intent(in) :: array
#endif
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

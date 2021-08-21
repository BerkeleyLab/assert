module something_m
  use assert_m, only : assert
  implicit none

  private
  public :: something_t

  type something_t
    private
    complex z_
    logical :: defined_=.false.
  contains 
    procedure z
    procedure defined
  end type

  interface

    pure module function z(self) result(self_z)
      class(something_t), intent(in) :: self
      complex self_z
    end function

    pure module function defined(self)
      class(something_t), intent(in) :: self
      logical defined
    end function

  end interface

  interface something_t
    pure module function construct(z) result(new_something_t)
      complex, intent(in) :: z
      type(something_t) new_something_t
    end function
  end interface

end module

submodule(something_m) something_s
  implicit none
contains

  module procedure z
    self_z = self%z_
  end procedure

  module procedure defined
    defined = self%defined_
  end procedure

  module procedure construct
    new_something_t%z_ = z
    new_something_t%defined_ = .true.
    call assert(new_something_t%defined(), "new_something_t%defined()") ! Postcondition
  end procedure

end submodule

module something_characterizable_m
  use something_m, only : something_t
  use characterizable_m, only : characterizable_t
  implicit none

  private
  public :: something_characterizable_t

  type, extends(characterizable_t) :: something_characterizable_t
    private
    type(something_t) something_
  contains
    procedure as_character
  end type

  interface

    pure module function as_character(self) result(character_self)
      implicit none
      class(something_characterizable_t), intent(in) :: self
      character(len=:), allocatable :: character_self
    end function

  end interface

  interface something_characterizable_t
    
    pure module function construct(something) result(new_something_characterizable)
      implicit none
      type(something_t), intent(in) :: something
      type(something_characterizable_t) :: new_something_characterizable
    end function

  end interface
  
end module 

submodule(something_characterizable_m) something_characterizable_s
  implicit none
contains

  module procedure as_character
    integer, parameter :: max_len=256
    character(len=max_len) untrimmed_string
    write(untrimmed_string,*) self%something_%z()
    character_self = trim(adjustl(untrimmed_string))
  end procedure

  module procedure construct
    new_something_characterizable%something_ = something
  end procedure

end submodule

program diagnostic_data_pattern
  !! Demonstrate a pattern for getting derived-type diagnostic data output from a type that
  !! does not extend characterizable_t.
  use assert_m, only : assert
  use something_m, only : something_t
  use something_characterizable_m, only : something_characterizable_t
  implicit none
 
  associate (imaginary_unit => something_t(z=(0.,1.)))
    ! Verify that the something_t constructor marks the object as defined
    call assert(imaginary_unit%defined(), "imaginary_unit%defined()", something_characterizable_t(imaginary_unit)) ! Passes
  end associate

  block
    type(something_t) something
    ! A failing check that an object has been marked as defined
    call assert(something%defined(),  "something%defined()", something_characterizable_t(something)) ! Fails 
  end block

end program

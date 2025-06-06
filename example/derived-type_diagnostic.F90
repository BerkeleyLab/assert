module stuff_m
  !! Example module with a type that does not extend characterizable_t.
  use assert_m, only : assert
  implicit none

  private
  public :: stuff_t

  type stuff_t
    !! Example type demonstrating how to get diagnostic data from a type
    !! that does not extend characterizable_t.
    private
    complex z_
    logical :: defined_=.false.
  contains 
    procedure z
    procedure defined
  end type

  interface

    pure module function z(self) result(self_z)
      !! Accessor: returns z_ component value
      class(stuff_t), intent(in) :: self
      complex self_z
    end function

    pure module function defined(self) result(self_defined)
      !! Result is true if the object has been marked as user-defined.
      class(stuff_t), intent(in) :: self
      logical self_defined
    end function

  end interface

  interface stuff_t
    pure module function construct(z) result(new_stuff_t)
      !! Constructor: result is a new stuff_t object.
      complex, intent(in) :: z
      type(stuff_t) new_stuff_t
    end function
  end interface

contains

  pure module function defined(self) result(self_defined)
    class(stuff_t), intent(in) :: self
    logical self_defined

    self_defined = self%defined_
  end function

  module procedure construct
    new_stuff_t%z_ = z
    new_stuff_t%defined_ = .true.
    call assert(new_stuff_t%defined(), "stuff_t construct(): new_stuff_t%defined()", new_stuff_t%defined_) ! Postcondition
  end procedure

  module procedure z
    call assert(self%defined(), "stuff_t%z(): self%defined()") ! Precondition
    self_z = self%z_
  end procedure

end module

module characterizable_stuff_m
  !! Demonstrate a pattern for getting derived-type diagnostic data output from a type that
  !! does not extend characterizable_t.
  use stuff_m, only : stuff_t
  use characterizable_m, only : characterizable_t
  implicit none

  private
  public :: characterizable_stuff_t

  type, extends(characterizable_t) :: characterizable_stuff_t
    !! Encapsulate the example type and extend characterizable_t to enable diagnostic-data 
    !! output in assertions.
    private
    type(stuff_t) stuff_
  contains
    procedure as_character
  end type

  interface

    pure module function as_character(self) result(character_self)
      !! Produce a character representation of the encapsulated type
      implicit none
      class(characterizable_stuff_t), intent(in) :: self
      character(len=:), allocatable :: character_self
    end function

  end interface

  interface characterizable_stuff_t
    
    pure module function construct(stuff) result(new_characterizable_stuff)
      !! Result is a new characterizable_stuff_t object
      implicit none
      type(stuff_t), intent(in) :: stuff
      type(characterizable_stuff_t) :: new_characterizable_stuff
    end function

  end interface
  
contains

  pure module function as_character(self) result(character_self)
      class(characterizable_stuff_t), intent(in) :: self
      character(len=:), allocatable :: character_self

    integer, parameter :: max_len=256
    character(len=max_len) untrimmed_string
    write(untrimmed_string,*) self%stuff_%z()
    character_self = trim(adjustl(untrimmed_string))
  end function

  module procedure construct
    new_characterizable_stuff%stuff_ = stuff
  end procedure

end module

program diagnostic_data_pattern
  !! Demonstrate 
  !! 1. A successful assertion with a derived-type diagnostic_data argument,
  !! 2. A failing internal assertion that prevents the use of undefined data.
  !! Item 1 also demonstrates the usefulness of a constructor postcondition.
  !! Item 2 also demonstrates the usefulness of an accessor precondition.
  use assert_m, only : assert
  use stuff_m, only : stuff_t
  use characterizable_stuff_m, only : characterizable_stuff_t
  implicit none

  type(stuff_t) stuff
 
#ifndef _CRAYFTN
  associate (i => stuff_t(z=(0.,1.)))
    call assert(i%defined(), "main: i%defined()", characterizable_stuff_t(i))!Passes: constructor postcondition ensures defined data
  end associate
#else
  block
    type(stuff_t) stuff
    stuff = stuff_t(z=(0.,1.))
    call assert(stuff%defined(), "main: i%defined()", characterizable_stuff_t(stuff))
  end block
#endif

  print *, stuff%z() ! Fails: accessor precondition catches use of undefined data

end program

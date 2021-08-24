submodule(intrinsic_array_m) intrinsic_array_s
  implicit none

contains

  module procedure construct

    select rank(array)
    rank(1)
      select type(array)
      type is(complex)
        intrinsic_array%c = array
      type is(integer)
        intrinsic_array%i = array
      type is(logical)
        intrinsic_array%l = array
      type is(real)
        intrinsic_array%r = array
      class default
        error  stop "intrinsic_array_t construct: unsupported type"
      end select
    rank default
      error  stop "intrinsic_array_t construct: unsupported rank"
    end select

  end procedure
  
  module procedure as_character
    integer, parameter :: single_number_width=32

    if (count([allocated(self%c), allocated(self%i), allocated(self%l), allocated(self%r)]) /= 1) &
      error stop "intrinsic_array_t as_character: ambiguous component allocation status."

    if (allocated(self%c)) then
      character_self = repeat(" ", ncopies = single_number_width*size(self%c))
      write(character_self, *) self%c
    else if (allocated(self%i)) then
      character_self = repeat(" ", ncopies = single_number_width*size(self%i))
      write(character_self, *) self%i
    else if (allocated(self%l)) then
      character_self = repeat(" ", ncopies = single_number_width*size(self%l))
      write(character_self, *) self%l
    else if (allocated(self%r)) then
      character_self = repeat(" ", ncopies = single_number_width*size(self%r))
      write(character_self, *) self%r
    end if

    character_self = trim(adjustl(character_self))
  end procedure 

end submodule intrinsic_array_s

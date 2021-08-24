submodule(characterizable_array_m) characterizable_array_s
  implicit none

contains

  module procedure characterizable_integer_array

    characterizable_array%a = array

#ifdef __GFORTRAN__
#else
    select rank(array)
    rank default
      error  stop "characterizable_array_t construct: unsupported rank"
    end select
#endif
  end procedure
  
  module procedure as_character
    integer, parameter :: single_number_width=32
    character_self = repeat(" ", ncopies = single_number_width*size(self%a))
    write(character_self, *) self%a
    character_self = trim(adjustl(character_self))
  end procedure 

end submodule characterizable_array_s

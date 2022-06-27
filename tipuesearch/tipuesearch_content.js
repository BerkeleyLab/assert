var tipuesearch = {"pages":[{"title":" Assert library ","text":"Assert library","tags":"home","loc":"index.html"},{"title":"characterizable_t – Assert library ","text":"type, public, abstract :: characterizable_t Inherited by type~~characterizable_t~~InheritedByGraph type~characterizable_t characterizable_t type~intrinsic_array_t intrinsic_array_t type~intrinsic_array_t->type~characterizable_t Help × Graph Key Nodes of different colours represent the following: Graph Key Type Type This Page's Entity This Page's Entity Solid arrows point from a derived type to the parent type which it\n    extends. Dashed arrows point from a derived type to the other\n    types it contains as a components, with a label listing the name(s) of\n    said component(s). Contents Type-Bound Procedures as_character Type-Bound Procedures procedure( as_character_i ), public, deferred :: as_character pure function as_character_i(self) result(character_self) Prototype Arguments Type Intent Optional Attributes Name class( characterizable_t ), intent(in) :: self Return Value character(len=:),allocatable","tags":"","loc":"type/characterizable_t.html"},{"title":"intrinsic_array_t – Assert library ","text":"type, public, extends( characterizable_t ) :: intrinsic_array_t Inherits type~~intrinsic_array_t~~InheritsGraph type~intrinsic_array_t intrinsic_array_t type~characterizable_t characterizable_t type~intrinsic_array_t->type~characterizable_t Help × Graph Key Nodes of different colours represent the following: Graph Key Type Type This Page's Entity This Page's Entity Solid arrows point from a derived type to the parent type which it\n    extends. Dashed arrows point from a derived type to the other\n    types it contains as a components, with a label listing the name(s) of\n    said component(s). Contents Variables complex_1D integer_1D logical_1D real_1D complex_2D integer_2D logical_2D real_2D complex_3D integer_3D logical_3D real_3D Constructor intrinsic_array_t Type-Bound Procedures as_character Components Type Visibility Attributes Name Initial complex, private, allocatable :: complex_1D (:) integer, private, allocatable :: integer_1D (:) logical, private, allocatable :: logical_1D (:) real, private, allocatable :: real_1D (:) complex, private, allocatable :: complex_2D (:,:) integer, private, allocatable :: integer_2D (:,:) logical, private, allocatable :: logical_2D (:,:) real, private, allocatable :: real_2D (:,:) complex, private, allocatable :: complex_3D (:,:,:) integer, private, allocatable :: integer_3D (:,:,:) logical, private, allocatable :: logical_3D (:,:,:) real, private, allocatable :: real_3D (:,:,:) Constructor public interface intrinsic_array_t private pure module function construct(array) result(intrinsic_array) Arguments Type Intent Optional Attributes Name class(*), intent(in) :: array (..) Return Value type( intrinsic_array_t ) Type-Bound Procedures procedure, public :: as_character interface private pure module module function as_character(self) result(character_self) Implementation → Arguments Type Intent Optional Attributes Name class( intrinsic_array_t ), intent(in) :: self Return Value character(len=:),allocatable","tags":"","loc":"type/intrinsic_array_t.html"},{"title":"as_character_i – Assert library","text":"abstract interface private pure function as_character_i(self) result(character_self) Arguments Type Intent Optional Attributes Name class( characterizable_t ), intent(in) :: self Return Value character(len=:),allocatable","tags":"","loc":"interface/as_character_i.html"},{"title":"assert – Assert library","text":"interface Calls interface~~assert~~CallsGraph interface~assert assert proc~assert assert interface~assert->proc~assert Help × Graph Key Nodes of different colours represent the following: Graph Key Subroutine Subroutine Function Function Interface Interface Unknown Procedure Type Unknown Procedure Type Program Program This Page's Entity This Page's Entity Solid arrows point from a procedure to one which it calls. Dashed \n    arrows point from an interface to procedures which implement that interface.\n    This could include the module procedures in a generic interface or the\n    implementation in a submodule of an interface in a parent module. public pure module module subroutine assert(assertion, description, diagnostic_data) Implementation → Arguments Type Intent Optional Attributes Name logical, intent(in) :: assertion Most assertions will be expressions such as i>0 character(len=*), intent(in) :: description A brief statement of what is being asserted such as \"i>0\" or \"positive i\" class(*), intent(in), optional :: diagnostic_data Data to include in an error ouptput: may be of an intrinsic type or a type that extends characterizable_t Description If assertion is .false., error-terminate with a character stop code that contains diagnostic_data if present","tags":"","loc":"interface/assert.html"},{"title":"intrinsic_array_t – Assert library","text":"public interface intrinsic_array_t Contents Functions construct Functions private pure module function construct(array) result(intrinsic_array) Arguments Type Intent Optional Attributes Name class(*), intent(in) :: array (..) Return Value type( intrinsic_array_t )","tags":"","loc":"interface/intrinsic_array_t.html"},{"title":"as_character – Assert library","text":"interface Calls interface~~as_character~~CallsGraph interface~as_character as_character proc~as_character as_character interface~as_character->proc~as_character Help × Graph Key Nodes of different colours represent the following: Graph Key Subroutine Subroutine Function Function Interface Interface Unknown Procedure Type Unknown Procedure Type Program Program This Page's Entity This Page's Entity Solid arrows point from a procedure to one which it calls. Dashed \n    arrows point from an interface to procedures which implement that interface.\n    This could include the module procedures in a generic interface or the\n    implementation in a submodule of an interface in a parent module. private pure module module function as_character(self) result(character_self) Implementation → Arguments Type Intent Optional Attributes Name class( intrinsic_array_t ), intent(in) :: self Return Value character(len=:),allocatable","tags":"","loc":"interface/as_character.html"},{"title":"assert – Assert library","text":"module procedure assert pure module module subroutine assert(assertion, description, diagnostic_data) Interface → Uses characterizable_m proc~~assert~~UsesGraph proc~assert assert module~characterizable_m characterizable_m proc~assert->module~characterizable_m Help × Graph Key Nodes of different colours represent the following: Graph Key Module Module Submodule Submodule Subroutine Subroutine Function Function Program Program This Page's Entity This Page's Entity Solid arrows point from a submodule to the (sub)module which it is\n    descended from. Dashed arrows point from a module or program unit to \n    modules which it uses. Arguments Type Intent Optional Attributes Name logical, intent(in) :: assertion Most assertions will be expressions such as i>0 character(len=*), intent(in) :: description A brief statement of what is being asserted such as \"i>0\" or \"positive i\" class(*), intent(in), optional :: diagnostic_data Data to include in an error ouptput: may be of an intrinsic type or a type that extends characterizable_t Called by proc~~assert~~CalledByGraph proc~assert assert interface~assert assert interface~assert->proc~assert Help × Graph Key Nodes of different colours represent the following: Graph Key Subroutine Subroutine Function Function Interface Interface Unknown Procedure Type Unknown Procedure Type Program Program This Page's Entity This Page's Entity Solid arrows point from a procedure to one which it calls. Dashed \n    arrows point from an interface to procedures which implement that interface.\n    This could include the module procedures in a generic interface or the\n    implementation in a submodule of an interface in a parent module. Contents None","tags":"","loc":"proc/assert.html"},{"title":"construct – Assert library","text":"module procedure construct module procedure construct() Arguments None Contents None","tags":"","loc":"proc/construct.html"},{"title":"as_character – Assert library","text":"module procedure as_character pure module module function as_character(self) result(character_self) Interface → Arguments Type Intent Optional Attributes Name class( intrinsic_array_t ), intent(in) :: self Return Value character(len=:),allocatable Called by proc~~as_character~~CalledByGraph proc~as_character as_character interface~as_character as_character interface~as_character->proc~as_character Help × Graph Key Nodes of different colours represent the following: Graph Key Subroutine Subroutine Function Function Interface Interface Unknown Procedure Type Unknown Procedure Type Program Program This Page's Entity This Page's Entity Solid arrows point from a procedure to one which it calls. Dashed \n    arrows point from an interface to procedures which implement that interface.\n    This could include the module procedures in a generic interface or the\n    implementation in a submodule of an interface in a parent module. Contents None","tags":"","loc":"proc/as_character.html"},{"title":"assert_m – Assert library","text":"use assertions_m, only : assert\n   call assert( 2 > 1, \"2 > 1\") Turn off assertions in production code by setting USE_ASSERTIONS to .false. via the preprocessor.\nThis file's capitalized .F90 extension causes most Fortran compilers to preprocess this file so\nthat building as follows turns off assertion enforcement: fpm build --flag \"-DUSE_ASSERTIONS=.false.\" Doing so may eliminate any associated runtime overhead by enabling optimizing compilers to ignore\nthe assertion procedure body during a dead-code-removal phase of optimization. Used by Descendants: assert_s module~~assert_m~~UsedByGraph module~assert_m assert_m module~assert_s assert_s module~assert_s->module~assert_m Help × Graph Key Nodes of different colours represent the following: Graph Key Module Module Submodule Submodule Subroutine Subroutine Function Function Program Program This Page's Entity This Page's Entity Solid arrows point from a submodule to the (sub)module which it is\n    descended from. Dashed arrows point from a module or program unit to \n    modules which it uses. Contents Variables enforce_assertions Interfaces assert Variables Type Visibility Attributes Name Initial logical, private, parameter :: enforce_assertions = .true. Turn off assertions as follows: fpm build --flag \"-DUSE_ASSERTIONS=.false.\" Interfaces interface public pure module module subroutine assert(assertion, description, diagnostic_data) Implementation → If assertion is .false., error-terminate with a character stop code that contains diagnostic_data if present Arguments Type Intent Optional Attributes Name logical, intent(in) :: assertion Most assertions will be expressions such as i>0 character(len=*), intent(in) :: description A brief statement of what is being asserted such as \"i>0\" or \"positive i\" class(*), intent(in), optional :: diagnostic_data Data to include in an error ouptput: may be of an intrinsic type or a type that extends characterizable_t","tags":"","loc":"module/assert_m.html"},{"title":"characterizable_m – Assert library","text":"Define an abstract class that supports object representation in character form Used by module~~characterizable_m~~UsedByGraph module~characterizable_m characterizable_m proc~assert assert proc~assert->module~characterizable_m module~intrinsic_array_m intrinsic_array_m module~intrinsic_array_m->module~characterizable_m module~intrinsic_array_s intrinsic_array_s module~intrinsic_array_s->module~intrinsic_array_m Help × Graph Key Nodes of different colours represent the following: Graph Key Module Module Submodule Submodule Subroutine Subroutine Function Function Program Program This Page's Entity This Page's Entity Solid arrows point from a submodule to the (sub)module which it is\n    descended from. Dashed arrows point from a module or program unit to \n    modules which it uses. Contents Abstract Interfaces as_character_i Derived Types characterizable_t Abstract Interfaces abstract interface private pure function as_character_i(self) result(character_self) Arguments Type Intent Optional Attributes Name class( characterizable_t ), intent(in) :: self Return Value character(len=:),allocatable Derived Types type, public, abstract :: characterizable_t Type-Bound Procedures procedure(as_character_i), public :: as_character","tags":"","loc":"module/characterizable_m.html"},{"title":"intrinsic_array_m – Assert library","text":"Define an abstract class that supports object representation in character form Uses characterizable_m module~~intrinsic_array_m~~UsesGraph module~intrinsic_array_m intrinsic_array_m module~characterizable_m characterizable_m module~intrinsic_array_m->module~characterizable_m Help × Graph Key Nodes of different colours represent the following: Graph Key Module Module Submodule Submodule Subroutine Subroutine Function Function Program Program This Page's Entity This Page's Entity Solid arrows point from a submodule to the (sub)module which it is\n    descended from. Dashed arrows point from a module or program unit to \n    modules which it uses. Used by Descendants: intrinsic_array_s module~~intrinsic_array_m~~UsedByGraph module~intrinsic_array_m intrinsic_array_m module~intrinsic_array_s intrinsic_array_s module~intrinsic_array_s->module~intrinsic_array_m Help × Graph Key Nodes of different colours represent the following: Graph Key Module Module Submodule Submodule Subroutine Subroutine Function Function Program Program This Page's Entity This Page's Entity Solid arrows point from a submodule to the (sub)module which it is\n    descended from. Dashed arrows point from a module or program unit to \n    modules which it uses. Contents Interfaces intrinsic_array_t as_character Derived Types intrinsic_array_t Interfaces public interface intrinsic_array_t private pure module function construct(array) result(intrinsic_array) Arguments Type Intent Optional Attributes Name class(*), intent(in) :: array (..) Return Value type( intrinsic_array_t ) interface private pure module module function as_character(self) result(character_self) Implementation → Arguments Type Intent Optional Attributes Name class( intrinsic_array_t ), intent(in) :: self Return Value character(len=:),allocatable Derived Types type, public, extends( characterizable_t ) :: intrinsic_array_t Components Type Visibility Attributes Name Initial complex, private, allocatable :: complex_1D (:) integer, private, allocatable :: integer_1D (:) logical, private, allocatable :: logical_1D (:) real, private, allocatable :: real_1D (:) complex, private, allocatable :: complex_2D (:,:) integer, private, allocatable :: integer_2D (:,:) logical, private, allocatable :: logical_2D (:,:) real, private, allocatable :: real_2D (:,:) complex, private, allocatable :: complex_3D (:,:,:) integer, private, allocatable :: integer_3D (:,:,:) logical, private, allocatable :: logical_3D (:,:,:) real, private, allocatable :: real_3D (:,:,:) Constructor private pure,module function construct (array) Type-Bound Procedures procedure, public :: as_character","tags":"","loc":"module/intrinsic_array_m.html"},{"title":"assert_s – Assert library","text":"Uses Ancestors: assert_m module~~assert_s~~UsesGraph module~assert_s assert_s module~assert_m assert_m module~assert_s->module~assert_m Help × Graph Key Nodes of different colours represent the following: Graph Key Module Module Submodule Submodule Subroutine Subroutine Function Function Program Program This Page's Entity This Page's Entity Solid arrows point from a submodule to the (sub)module which it is\n    descended from. Dashed arrows point from a module or program unit to \n    modules which it uses. Contents Module Procedures assert Module Procedures module procedure assert pure module module subroutine assert(assertion, description, diagnostic_data) Interface → Arguments Type Intent Optional Attributes Name logical, intent(in) :: assertion Most assertions will be expressions such as i>0 character(len=*), intent(in) :: description A brief statement of what is being asserted such as \"i>0\" or \"positive i\" class(*), intent(in), optional :: diagnostic_data Data to include in an error ouptput: may be of an intrinsic type or a type that extends characterizable_t","tags":"","loc":"module/assert_s.html"},{"title":"intrinsic_array_s – Assert library","text":"Uses Ancestors: intrinsic_array_m module~~intrinsic_array_s~~UsesGraph module~intrinsic_array_s intrinsic_array_s module~intrinsic_array_m intrinsic_array_m module~intrinsic_array_s->module~intrinsic_array_m module~characterizable_m characterizable_m module~intrinsic_array_m->module~characterizable_m Help × Graph Key Nodes of different colours represent the following: Graph Key Module Module Submodule Submodule Subroutine Subroutine Function Function Program Program This Page's Entity This Page's Entity Solid arrows point from a submodule to the (sub)module which it is\n    descended from. Dashed arrows point from a module or program unit to \n    modules which it uses. Contents Module Procedures construct as_character Module Procedures module procedure construct module procedure construct() Arguments None module procedure as_character pure module module function as_character(self) result(character_self) Interface → Arguments Type Intent Optional Attributes Name class( intrinsic_array_t ), intent(in) :: self Return Value character(len=:),allocatable","tags":"","loc":"module/intrinsic_array_s.html"},{"title":"assert_s.f90 – Assert library","text":"This file depends on sourcefile~~assert_s.f90~~EfferentGraph sourcefile~assert_s.f90 assert_s.f90 sourcefile~assert_m.f90 assert_m.F90 sourcefile~assert_s.f90->sourcefile~assert_m.f90 sourcefile~characterizable_m.f90 characterizable_m.f90 sourcefile~assert_s.f90->sourcefile~characterizable_m.f90 Help × Graph Key Nodes of different colours represent the following: Graph Key Source File Source File This Page's Entity This Page's Entity Solid arrows point from a file to a file which it depends on. A file\n    is dependent upon another if the latter must be compiled before the former\n    can be. Contents Submodules assert_s Source Code assert_s.f90 Source Code ! !     (c) 2019-2020 Guide Star Engineering, LLC !     This Software was developed for the US Nuclear Regulatory Commission (US NRC) under contract !     \"Multi-Dimensional Physics Implementation into Fuel Analysis under Steady-state and Transients (FAST)\", !     contract # NRC-HQ-60-17-C-0007 ! submodule ( assert_m ) assert_s implicit none contains module procedure assert use characterizable_m , only : characterizable_t character ( len = :), allocatable :: header , trailer toggle_assertions : & if ( enforce_assertions ) then check_assertion : & if (. not . assertion ) then associate ( me => this_image ()) ! work around gfortran bug header = 'Assertion \"' // description // '\" failed on image ' // string ( me ) end associate represent_diagnostics_as_string : & if (. not . present ( diagnostic_data )) then trailer = \"(none provided)\" else select type ( diagnostic_data ) type is ( character ( len =* )) trailer = diagnostic_data type is ( complex ) trailer = string ( diagnostic_data ) type is ( integer ) trailer = string ( diagnostic_data ) type is ( logical ) trailer = string ( diagnostic_data ) type is ( real ) trailer = string ( diagnostic_data ) class is ( characterizable_t ) trailer = diagnostic_data % as_character () class default trailer = \"of unsupported type.\" end select end if represent_diagnostics_as_string error stop header // ' with diagnostic data \"' // trailer // '\"' end if check_assertion end if toggle_assertions contains pure function string ( numeric ) result ( number_as_string ) !! Result is a string represention of the numeric argument class ( * ), intent ( in ) :: numeric integer , parameter :: max_len = 128 character ( len = max_len ) :: untrimmed_string character ( len = :), allocatable :: number_as_string select type ( numeric ) type is ( complex ) write ( untrimmed_string , * ) numeric type is ( integer ) write ( untrimmed_string , * ) numeric type is ( logical ) write ( untrimmed_string , * ) numeric type is ( real ) write ( untrimmed_string , * ) numeric class default error stop \"Internal error in subroutine 'assert': unsupported type in function 'string'.\" end select number_as_string = trim ( adjustl ( untrimmed_string )) end function string end procedure end submodule","tags":"","loc":"sourcefile/assert_s.f90.html"},{"title":"assert_m.F90 – Assert library","text":"Files dependent on this one sourcefile~~assert_m.f90~~AfferentGraph sourcefile~assert_m.f90 assert_m.F90 sourcefile~assert_s.f90 assert_s.f90 sourcefile~assert_s.f90->sourcefile~assert_m.f90 Help × Graph Key Nodes of different colours represent the following: Graph Key Source File Source File This Page's Entity This Page's Entity Solid arrows point from a file to a file which it depends on. A file\n    is dependent upon another if the latter must be compiled before the former\n    can be. Contents Modules assert_m Source Code assert_m.F90 Source Code ! !     (c) 2019-2020 Guide Star Engineering, LLC !     This Software was developed for the US Nuclear Regulatory Commission (US NRC) under contract !     \"Multi-Dimensional Physics Implementation into Fuel Analysis under Steady-state and Transients (FAST)\", !     contract # NRC-HQ-60-17-C-0007 ! module assert_m !! summary: Utility for runtime checking of logical assertions. !! usage: error-terminate if the assertion fails: !! !!    use assertions_m, only : assert !!    call assert( 2 > 1, \"2 > 1\") !! !! Turn off assertions in production code by setting USE_ASSERTIONS to .false. via the preprocessor. !! This file's capitalized .F90 extension causes most Fortran compilers to preprocess this file so !! that building as follows turns off assertion enforcement: !! !!    fpm build --flag \"-DUSE_ASSERTIONS=.false.\" !! !! Doing so may eliminate any associated runtime overhead by enabling optimizing compilers to ignore !! the assertion procedure body during a dead-code-removal phase of optimization. implicit none private public :: assert #ifndef USE_ASSERTIONS # define USE_ASSERTIONS .true. #endif logical , parameter :: enforce_assertions = USE_ASSERTIONS !! Turn off assertions as follows: fpm build --flag \"-DUSE_ASSERTIONS=.false.\" interface pure module subroutine assert ( assertion , description , diagnostic_data ) !! If assertion is .false., error-terminate with a character stop code that contains diagnostic_data if present implicit none logical , intent ( in ) :: assertion !! Most assertions will be expressions such as i>0 character ( len =* ), intent ( in ) :: description !! A brief statement of what is being asserted such as \"i>0\" or \"positive i\" class ( * ), intent ( in ), optional :: diagnostic_data !! Data to include in an error ouptput: may be of an intrinsic type or a type that extends characterizable_t end subroutine end interface end module","tags":"","loc":"sourcefile/assert_m.f90.html"},{"title":"characterizable_m.f90 – Assert library","text":"Files dependent on this one sourcefile~~characterizable_m.f90~~AfferentGraph sourcefile~characterizable_m.f90 characterizable_m.f90 sourcefile~intrinsic_array_m.f90 intrinsic_array_m.F90 sourcefile~intrinsic_array_m.f90->sourcefile~characterizable_m.f90 sourcefile~assert_s.f90 assert_s.f90 sourcefile~assert_s.f90->sourcefile~characterizable_m.f90 sourcefile~intrinsic_array_s.f90 intrinsic_array_s.F90 sourcefile~intrinsic_array_s.f90->sourcefile~intrinsic_array_m.f90 Help × Graph Key Nodes of different colours represent the following: Graph Key Source File Source File This Page's Entity This Page's Entity Solid arrows point from a file to a file which it depends on. A file\n    is dependent upon another if the latter must be compiled before the former\n    can be. Contents Modules characterizable_m Source Code characterizable_m.f90 Source Code module characterizable_m !! Define an abstract class that supports object representation in character form implicit none private public :: characterizable_t type , abstract :: characterizable_t contains procedure ( as_character_i ), deferred :: as_character end type abstract interface pure function as_character_i ( self ) result ( character_self ) import characterizable_t implicit none class ( characterizable_t ), intent ( in ) :: self character ( len = :), allocatable :: character_self end function end interface end module characterizable_m","tags":"","loc":"sourcefile/characterizable_m.f90.html"},{"title":"intrinsic_array_s.F90 – Assert library","text":"This file depends on sourcefile~~intrinsic_array_s.f90~~EfferentGraph sourcefile~intrinsic_array_s.f90 intrinsic_array_s.F90 sourcefile~intrinsic_array_m.f90 intrinsic_array_m.F90 sourcefile~intrinsic_array_s.f90->sourcefile~intrinsic_array_m.f90 sourcefile~characterizable_m.f90 characterizable_m.f90 sourcefile~intrinsic_array_m.f90->sourcefile~characterizable_m.f90 Help × Graph Key Nodes of different colours represent the following: Graph Key Source File Source File This Page's Entity This Page's Entity Solid arrows point from a file to a file which it depends on. A file\n    is dependent upon another if the latter must be compiled before the former\n    can be. Contents Submodules intrinsic_array_s Source Code intrinsic_array_s.F90 Source Code submodule ( intrinsic_array_m ) intrinsic_array_s implicit none contains module procedure construct #ifndef NAGFOR select rank ( array ) rank ( 1 ) #endif select type ( array ) type is ( complex ) intrinsic_array % complex_1D = array type is ( integer ) intrinsic_array % integer_1D = array type is ( logical ) intrinsic_array % logical_1D = array type is ( real ) intrinsic_array % real_1D = array class default error stop \"intrinsic_array_t construct: unsupported rank-2 type\" end select #ifndef NAGFOR rank ( 2 ) select type ( array ) type is ( complex ) intrinsic_array % complex_2D = array type is ( integer ) intrinsic_array % integer_2D = array type is ( logical ) intrinsic_array % logical_2D = array type is ( real ) intrinsic_array % real_2D = array class default error stop \"intrinsic_array_t construct: unsupported rank-2 type\" end select rank ( 3 ) select type ( array ) type is ( complex ) intrinsic_array % complex_3D = array type is ( integer ) intrinsic_array % integer_3D = array type is ( logical ) intrinsic_array % logical_3D = array type is ( real ) intrinsic_array % real_3D = array class default error stop \"intrinsic_array_t construct: unsupported rank-3 type\" end select rank default error stop \"intrinsic_array_t construct: unsupported rank\" end select #endif end procedure module procedure as_character integer , parameter :: single_number_width = 32 if ( 1 /= count ( & [ allocated ( self % complex_1D ), allocated ( self % integer_1D ), allocated ( self % logical_1D ), allocated ( self % real_1D ) & , allocated ( self % complex_2D ), allocated ( self % integer_2D ), allocated ( self % logical_2D ), allocated ( self % real_2D ) & ])) error stop \"intrinsic_array_t as_character: ambiguous component allocation status.\" if ( allocated ( self % complex_1D )) then character_self = repeat ( \" \" , ncopies = single_number_width * size ( self % complex_1D )) write ( character_self , * ) self % complex_1D else if ( allocated ( self % integer_1D )) then character_self = repeat ( \" \" , ncopies = single_number_width * size ( self % integer_1D )) write ( character_self , * ) self % integer_1D else if ( allocated ( self % logical_1D )) then character_self = repeat ( \" \" , ncopies = single_number_width * size ( self % logical_1D )) write ( character_self , * ) self % logical_1D else if ( allocated ( self % real_1D )) then character_self = repeat ( \" \" , ncopies = single_number_width * size ( self % real_1D )) write ( character_self , * ) self % real_1D else if ( allocated ( self % complex_2D )) then character_self = repeat ( \" \" , ncopies = single_number_width * size ( self % complex_2D )) write ( character_self , * ) self % complex_2D else if ( allocated ( self % integer_2D )) then character_self = repeat ( \" \" , ncopies = single_number_width * size ( self % integer_2D )) write ( character_self , * ) self % integer_2D else if ( allocated ( self % logical_2D )) then character_self = repeat ( \" \" , ncopies = single_number_width * size ( self % logical_1D )) write ( character_self , * ) self % logical_2D else if ( allocated ( self % real_2D )) then character_self = repeat ( \" \" , ncopies = single_number_width * size ( self % real_2D )) write ( character_self , * ) self % real_2D end if character_self = trim ( adjustl ( character_self )) end procedure end submodule intrinsic_array_s","tags":"","loc":"sourcefile/intrinsic_array_s.f90.html"},{"title":"intrinsic_array_m.F90 – Assert library","text":"This file depends on sourcefile~~intrinsic_array_m.f90~~EfferentGraph sourcefile~intrinsic_array_m.f90 intrinsic_array_m.F90 sourcefile~characterizable_m.f90 characterizable_m.f90 sourcefile~intrinsic_array_m.f90->sourcefile~characterizable_m.f90 Help × Graph Key Nodes of different colours represent the following: Graph Key Source File Source File This Page's Entity This Page's Entity Solid arrows point from a file to a file which it depends on. A file\n    is dependent upon another if the latter must be compiled before the former\n    can be. Files dependent on this one sourcefile~~intrinsic_array_m.f90~~AfferentGraph sourcefile~intrinsic_array_m.f90 intrinsic_array_m.F90 sourcefile~intrinsic_array_s.f90 intrinsic_array_s.F90 sourcefile~intrinsic_array_s.f90->sourcefile~intrinsic_array_m.f90 Help × Graph Key Nodes of different colours represent the following: Graph Key Source File Source File This Page's Entity This Page's Entity Solid arrows point from a file to a file which it depends on. A file\n    is dependent upon another if the latter must be compiled before the former\n    can be. Contents Modules intrinsic_array_m Source Code intrinsic_array_m.F90 Source Code module intrinsic_array_m !! Define an abstract class that supports object representation in character form use characterizable_m , only : characterizable_t implicit none private public :: intrinsic_array_t type , extends ( characterizable_t ) :: intrinsic_array_t complex , allocatable :: complex_1D (:) integer , allocatable :: integer_1D (:) logical , allocatable :: logical_1D (:) real , allocatable :: real_1D (:) complex , allocatable :: complex_2D (:,:) integer , allocatable :: integer_2D (:,:) logical , allocatable :: logical_2D (:,:) real , allocatable :: real_2D (:,:) complex , allocatable :: complex_3D (:,:,:) integer , allocatable :: integer_3D (:,:,:) logical , allocatable :: logical_3D (:,:,:) real , allocatable :: real_3D (:,:,:) contains procedure :: as_character end type interface intrinsic_array_t pure module function construct ( array ) result ( intrinsic_array ) implicit none #ifndef NAGFOR class ( * ), intent ( in ) :: array (..) #else class ( * ), intent ( in ) :: array (:) #endif type ( intrinsic_array_t ) intrinsic_array end function end interface interface pure module function as_character ( self ) result ( character_self ) implicit none class ( intrinsic_array_t ), intent ( in ) :: self character ( len = :), allocatable :: character_self end function end interface end module intrinsic_array_m","tags":"","loc":"sourcefile/intrinsic_array_m.f90.html"}]}
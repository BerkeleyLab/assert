! assert_macros.h: provides preprocessor-based assertion macros
! that are guaranteed to compile away statically when disabled.

! Enable repeated includes to toggle assertions based on current settings:
#undef call_assert
#undef call_assert_describe
#undef call_assert_diagnose

#ifndef ASSERTIONS
! Assertions are off by default
#define ASSERTIONS 0
#endif

#if ASSERTIONS
# define call_assert(assertion) call assert(assertion, "No description provided (see file " // __FILE__ // ", line " // string(__LINE__) // ")")
# define call_assert_describe(assertion, description) call assert(assertion, description // " in file " // __FILE__ // ", line " // string(__LINE__) // ": " )
# define call_assert_diagnose(assertion, description, diagnostic_data) call assert(assertion, "file " // __FILE__ // ", line " // string(__LINE__) // ": " // description, diagnostic_data)
#else
# define call_assert(assertion)
# define call_assert_describe(assertion, description)
# define call_assert_diagnose(assertion, description, diagnostic_data)
#endif

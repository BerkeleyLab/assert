#ifdef DEBUG
# define call_assert(assertion) call assert(assertion, "No description provided (see file " // __FILE__ // ", line " // string(__LINE__) // ")")
# define call_assert_describe(assertion, description) call assert(assertion, description // " in file " // __FILE__ // ", line " // string(__LINE__) // ": " )
# define call_assert_diagnose(assertion, description, diagnostic_data) call assert(assertion, "file " // __FILE__ // ", line " // string(__LINE__) // ": " // description, diagnostic_data)
#else
# define call_assert(assertion)
# define call_assert_describe(assertion, description)
# define call_assert_diagnose(assertion, description, diagnostic_data)
#endif

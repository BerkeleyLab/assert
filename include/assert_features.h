#ifndef _ASSERT_FEATURES_H
#define _ASSERT_FEATURES_H

! Whether or not the assert library may use multi-image features
! Default is compiler-dependent
#ifndef ASSERT_MULTI_IMAGE
#  if defined(__flang__) || defined(__INTEL_COMPILER)
#    define ASSERT_MULTI_IMAGE 0
#  else
#    define ASSERT_MULTI_IMAGE 1
#  endif
#endif

#endif

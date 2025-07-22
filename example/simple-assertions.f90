program assertion_examples
  !! Demonstrate the use of assertions as runtime checks on the satisfaction of 
  !! of two kinds of constraints:
  !! 1. Preconditions: requirements for correct execution at the start of a procedure and
  !! 2. Postconditions: requirements for correct execution at the end of a procedure.
  use assert_m, only : assert
  implicit none
  
  print *, "roots: ", roots(a=1.,b=0.,c=-4.)

contains

  pure function roots(a,b,c) result(zeros)
    !! Calculate the roots of a quadratic polynomial
    real, intent(in) :: a, b, c
    real, allocatable :: zeros(:)
    real, parameter :: tolerance = 1E-06

    associate(discriminant => b**2 - 4*a*c)
      call assert(assertion = discriminant >= 0., description = "discriminant >= 0") ! precondition
      allocate(zeros(2))
      ! there's a deliberate math bug in the following line, to help demonstrate assertion failure
      zeros = -b + [sqrt(discriminant), -sqrt(discriminant)]
    end associate

    ! This assertion will fail (due to the defect above) when ASSERTIONS are enabled:
    call assert(all(abs(a*zeros**2 + b*zeros + c) < tolerance), "All residuals within tolerance.") ! postcondition
  end function

end program

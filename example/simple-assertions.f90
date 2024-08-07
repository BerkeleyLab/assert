program assertion_examples
  !! Demonstrate the use of assertions as runtime checks on the satisfaction of 
  !! of two kinds of constraints:
  !! 1. Preconditions: requirements for correct execution at the start of a procedure and
  !! 2. Postconditions: requirements for correct execution at the end of a procedure.
  use assert_m, only : assert
  use intrinsic_array_m, only : intrinsic_array_t
  implicit none
  
  print *, "roots: ", roots(a=1.,b=0.,c=-4.)

contains

  pure function roots(a,b,c) result(zeros)
    !! Calculate the roots of a quadratic polynomial
    real, intent(in) :: a, b, c
    real zeros(2)

    associate(discriminant => b**2 - 4*a*c)
      call assert(assertion = (discriminant >= 0.), description = "roots: nonnegative discriminant", diagnostic_data = discriminant)

      associate(radical => sqrt(discriminant))
        zeros = [-b + radical, -b - radical]/(2*a)

        block
          real, parameter :: tolerance = 1.E-06

          associate(errors => a*zeros**2 + b*zeros + c)
            call assert(maxval(abs(errors)) < tolerance, "roots: |max(error)| > tolerance", intrinsic_array_t([errors]))
          end associate
        end block
      end associate
    end associate

  end function

end program

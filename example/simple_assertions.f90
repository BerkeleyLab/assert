program assertion_examples
  !! Demonstrate the use of assertions as runtime checks on the satisfaction of 
  !! of two kinds of constraints:
  !! 1. Preconditions: requirements for correct execution at the start of a procedure and
  !! 2. Postconditions: requirements for correct execution at the end of a procedure.
  implicit none
  
  print *, reciprocal(2.)

contains

  pure real function reciprocal(x) result(reciprocal_of_x)
    !! Erroneous calculation of the reciprocal of the function's argument
    use assert_m, only : assert
    real, intent(in) :: x

    call assert(assertion = x /= 0., description = "reciprocal: x /= 0", diagnostic_data = x) ! Precondition passes

    reciprocal_of_x = 0. ! incorrect value for the reciprocal of x

    block
      real, parameter :: tolerance = 1.E-06

      associate(error => x*reciprocal_of_x - 1.) 

        call assert(abs(error) < tolerance, "reciprocal: abs(error) < tolerance", error) ! Postcondition fails

      end associate
    end block

  end function

end program

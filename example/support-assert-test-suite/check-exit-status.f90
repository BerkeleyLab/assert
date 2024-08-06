program check_exit_status
  ! Despite its location in the example subdirectory, this program is _not_ intended to
  ! be a user-facing example. This program exists to work around an LLVM Flang (flang-new)
  ! compiler issue. This program is invoked by test/test-assert-subroutine-error-termination.F90,
  ! which reads the file this program writes to determine the exist status of the program
  ! example/false-assertion.f90. The latter  program intentionally error terminates in order
  ! to test the case wehn assertion = .false.
  implicit none
  integer exit_status, unit
  read(*,*) exit_status
  open(newunit=unit, file="build/exit_status", status="unknown")
  write(unit,*) exit_status
  close(unit)
end program 

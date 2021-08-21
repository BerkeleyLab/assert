Assert
======

A simple assertion utility taking advantage of the Fortran 2018 standard's introduction of variable stop codes and error termination inside pure procedures.

Motivations
-----------
1. To mitigate against a reason developers often cite for not writing `pure` procedures: their inability to produce output in normal execution.
2. To promote the enforcement of programming contracts.

Overview
--------
This assertion utility contains just one public procedure: an `assert` subroutine that

1. error-terminates with a variable stop code when a user-defined logical assertion fails,
2. includes user-supplied diagnostic data in the output if provided by the calling procedure,
3. is callable inside `pure` procedures, and
4. can be eliminated by an optimizing compiler through the use of a preprocessor macro: `-DUSE_ASSERTIONS=.false.`.

The intended uses cases are twofold: (1) enforcing programming contracts throughout a project
and (2) providing a convenient way to get temporarily produce output for debugging purposes.o

Contracts enforce

1. Preconditions (requirements): `logical` expressions that must evaluate to `.true.` when a procedure starts execution,
2. Postconditions (assurances): expressions that must evaluate to `.false.`
3. Invariants: universal pre- and postconditions that must always be true when all procedures in a class or package start or finish executing.

Examples
--------
See [./examples](./examples). 

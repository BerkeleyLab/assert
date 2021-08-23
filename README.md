Assert
======

A simple assertion utility taking advantage of the Fortran 2018 standard's introduction of variable stop codes and error termination inside pure procedures.

Motivations
-----------
1. To mitigate against a reason developers often cite for not writing `pure` procedures: their inability to produce output in normal execution.
2. To promote the enforcement of programming contracts.

Overview
--------
This assertion utility contains one public procedure and one public abstract type: `assert` and `characterizable_t`, respectively.
The `assert` subroutine

1. error-terminates with a variable stop code when a user-defined logical assertion fails,
2. includes user-supplied diagnostic data in the output if provided by the calling procedure,
3. is callable inside `pure` procedures, and
4. can be eliminated during an optimizing compiler's dead-code removal phase based on a preprocessor macro: `-DUSE_ASSERTIONS=.false.`.

The `characterizable_t` abstract derived type provides a mechanism for obtaining diagnostic data from a user-defined derived type that implements the `characterizable_t`'s `as_character()` deferred binding.

Use Cases
---------
1. [Enforcing programming contracts] throughout a project via runtime checks.
2. Produce output in `pure` procedures for debugging purposes.

### Enforcing programming contracts

1. Preconditions (requirements): `logical` expressions that must evaluate to `.true.` when a procedure starts execution,
2. Postconditions (assurances): expressions that must evaluate to `.false.`
3. Invariants: universal pre- and postconditions that must always be true when all procedures in a class or package start or finish executing.

### Examples
See the [./example](./example) subdirectory.

Downloading, Building, and Running Examples
-------------------------------------------
Prerequisites:
1. A Fortran 2018 compiler (recent Cray, Intel, GNU, and NAG compiler versions suffice).  
2. The [Fortran Package Manager](https://github.com/fortran-lang/fpm).
3. _Optional_: [OpenCoarrays] for parallel execution with the GNU Fortran compiler.

### Single-image (serial) execution
```
git clone git@github.com/sourceryinstitute/assert
cd assert
fpm --example simple_assertions
fpm --example derived_type_diagnostic

```

### Multi-image (parallel) execution with `gfortran` and OpenCoarrays
```
git clone git@github.com/sourceryinstitute/assert
cd assert
fpm build --compiler caf
fpm run --runner cafrun -flag "-n 2" --example simple_assertions
fpm run --runner cafrun -flag "-n 2" --example derived_type_diagnostic
``` 

[OpenCoarrays]: https://github.com/sourceryinstitute/opencoarrays
[Enforcing programming contracts]: #enforcing-programming-contracts

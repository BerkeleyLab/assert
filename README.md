Assert
======

A simple assertion utility taking advantage of the Fortran 2018 standard's introduction of variable stop codes
and error termination inside pure procedures.

Motivations
-----------
1. To mitigate against a reason developers often cite for not writing `pure` procedures: their inability to produce output in normal execution.
2. To promote the enforcement of programming contracts.

Overview
--------
This assertion utility contains three public entities:

1. an `assert` subroutine,
2. a `characterizable_t` abstract type supporting `assert`, and
3. an `intrinsic_array_t` non-abstract type extending `characterizable_t`.

The `assert` subroutine

1. error-terminates with a variable stop code when a user-defined logical assertion fails,
2. includes user-supplied diagnostic data in the output if provided by the calling procedure,
3. is callable inside `pure` procedures, and
4. can be eliminated during an optimizing compiler's dead-code removal phase based on a preprocessor macro: `-DUSE_ASSERTIONS=.false.`.

The `characterizable_t` type defines an `as_character()` deferred binding that produces `character` strings for use as diagnostic output from a user-defined derived type that extends  `characterizable_t` and ipmlements the deferred binding.

The `intrinsic_array_t` type that extends `characterizable_t` provides a convenient mechanism for producing diagnostic output from arrays of intrinsic type `complex`, `integer`, `logical`, or `real`.

Use Cases
---------
1. [Enforcing programming contracts] throughout a project via runtime checks.
2. Produce output in `pure` procedures for debugging purposes.

### Enforcing programming contracts

1. Preconditions (requirements): `logical` expressions that must evaluate to `.true.` when a procedure starts execution,
2. Postconditions (assurances): expressions that must evaluate to `.false.`
3. Invariants: universal pre- and postconditions that must always be true when all procedures in a class or package start or finish executing.


Downloading, Building, and Running Examples
-------------------------------------------

### Prerequisites
1. A Fortran 2018 compiler.
2. The [Fortran Package Manager].
3. _Optional_: [OpenCoarrays] for parallel execution with the GNU Fortran compiler.

Recent versions of the Cray, Intel, GNU, and NAG compilers suffice.  Assert was developed primarily with `gfortran` 11.1.0 and `nagfor` 7.0 Build 7044.

### Downloading, building, and testing

#### Downloading Assert
```
git clone git@github.com:sourceryinstitute/assert
cd assert
```

#### Building Assert for single-image (serial) execution
```
fpm test
fpm run --example simple_assertions
fpm run --example derived_type_diagnostic
```
where `fpm test` builds the Assert library and runs the test suite, including the tests.

#### Building Assert for multi-image (parallel) execution
With `gfortran` and OpenCoarrays installed,
```
fpm test --compiler caf --runner "cafrun -n 2" unit_tests
fpm test --compiler caf --runner "cafrun -n 2" intentionally-failing-tests
fpm run --example simple_assertions
fpm run --example derived_type_diagnostic
```

Please submit an issue to request documentation on using Assert with other compilers or submit a pull request to add such documenation.  

### Running the examples
See the [./example](./example) subdirectory.

Documentation
-------------
For further documentation, please see [example/README.md] and the [tests].  Also, the code in [src] has comments formatted for generating HTML documentation using [FORD].

[Hyperlinks]:#
[OpenCoarrays]: https://github.com/sourceryinstitute/opencoarrays
[Enforcing programming contracts]: #enforcing-programming-contracts
[Single-image execution]: #single-image-execution
[example/README.md]: ./example/README.md
[tests]: ./tests
[src]: ./src
[FORD]: https://github.com/Fortran-FOSS-Programmers/ford
[Fortran Package Manager]: https://github.com/fortran-lang/fpm

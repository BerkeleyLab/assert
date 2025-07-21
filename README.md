Assert
======

An assertion utility that combines variable stop codes and error termination in `pure` procedures to produce descriptive messages when a program detects violations of the requirements for correct execution.

Motivations
-----------
1. To mitigate against a reason developers often cite for not writing `pure` procedures: their inability to produce output in normal execution.
2. To promote the enforcement of programming contracts.

Overview
--------
This assertion utility contains four public entities:

* An `assert_macros.h` file defining the recommended preprocessor macros for writing assertions:
  - `call_assert(assertion)`
  - `call_assert_describe(assertion, description)`
* An `assert` subroutine

The `assert` subroutine
* Error-terminates with a variable stop code when a caller-provided logical assertion fails,
* Is callable inside `pure` procedures, and
* Can be eliminated by not defining the `ASSERTIONS` preprocessor macro.

Assertion enforcement is controlled via the `ASSERTIONS` preprocessor macro,
which can be defined to non-zero or zero at compilation time to
respectively enable or disable run-time assertion enforcement.

When the `ASSERTIONS` preprocessor macro is not defined to any value,
the default is that assertions are *disabled* and will not check the condition.

To enable assertion enforcement (e.g., for a debug build), define the
preprocessor ASSERTIONS to non-zero, e.g.,
```
fpm build --flag "-DASSERTIONS"
```
The program [example/invoke-via-macro.F90] demonstrates the preferred way to invoke assertions via the three provided macros. 
Invoking assertions this way ensures such calls will be completely removed whenever the `ASSERTIONS` macro is undefined (or defined to zero) during compilation.
Due to a limitation of `fpm`, this approach works best if the project using Assert is also a `fpm` project.
If instead `fpm install` is used, then either the user must copy `include/assert_macros.h` to the installation directory (default: `~/.local/include`) or 
the user must invoke `assert` directly (via `call assert(...)`).
In the latter approach when the assertions are disabled, the `assert` procedure will start and end with `if (.false.) then ... end if`, which might facilitate automatic removal of `assert` during the dead-code removal phase of optimizing compilers.

Use Cases
---------
Two common use cases include

1. [Producing output in pure procedures] for debugging purposes.
2. [Enforcing programming contracts] throughout a project via runtime checks.

### Producing output in pure procedures
Writing pure procedures communicates useful information to a compiler or a developer.
Specifically, the pure attribute conveys compliance with several constraints that clarify data dependencies and preclude most side effects.
For a compiler, these constraints support optimizations, including automatic parallelization on a central processing unit (CPU) or offloading to a graphics processing unit (GPU).
For a developer, the constraints support refactoring tasks such as code movement.

A developer seeking output inside a procedure presumably has an expectation regarding what ranges of output values represent correct program execution.
A developer can state such expectations in an assertion such as `call_assert(i>0 .and. j<0)`.
Enforce the assertion by defining the `ASSERTIONS` macro when compiling.
If the expectation is not met, the program error terminates and prints a stop code showing the assertion's file and line location and a description.
By default, the description is the literal text of what was asserted: `i>0 .and. j<0` in the aforementioned example.
Alternatively, the user can provide a custom description.

For richer diagnostic messages from failed assertions, please see the [Julienne] correctness-checking framework.
Julienne wraps Assert and defines idioms that automatically generate diagnostic messages containing program data.
Julienne also offers string-handling utilities to assist users with customizing diagnostic messages by, for example, converting an array of numeric type into string representing comma-separated values as text.

### Enforcing programming contracts
Programming can be thought of as requirements for correct execution of a procedure and assurances for the result of correct execution.
The requirements and assurances might be constraints of three kinds:

1. **Preconditions (requirements):** `logical` expressions that must evaluate to `.true.` when a procedure starts execution,
2. **Postconditions (assurances):** expressions that must evaluate to `.true.` when a procedure finishes execution, and
3. **Invariants:** universal pre- and postconditions that must always be true when all procedures in a class start or finish executing.

The [example/README.md] file shows examples of writing constraints in notes on class diagrams using the formal syntax of the Object Constraint Language ([OCL]).

Running the Examples
--------------------
See the [./example](./example) subdirectory.

Building and Testing
--------------------

- [Cray Compiler Environment (CCE) `ftn`](#cray-compiler-environment-cce-ftn)
- [GNU Compiler Collection (GCC) `gfortran`](#gnu-compiler-collection-gcc-gfortran))
- [Intel `ifx`](#intel-ifx))
- [LFortran `lfortran`](#lfortran-lfortran)
- [LLVM `flang-new`](#llvm-flang-new)
- [Numerical Algorithms Group (NAG) `nagfor`](#numerical-algorithms-group-nag-nagfor)

### Cray Compiler Environment (CCE) `ftn`
Because `fpm` uses the compiler name to determine the compiler identity and because
CCE provides one compiler wrapper, `ftn`, for invoking all compilers, you will
need to invoke `ftn` in a shell script named to identify CCE compiler. For example,
place a script named `crayftn.sh` in your path with the following contents and with
executable privileges set appropriately:
```
#!/bin/bash

ftn $@
```
Then build and test Assert with the command
```
fpm test --compiler crayftn.sh --profile release
```

### GNU Compiler Collection (GCC) `gfortran`

#### Single-image (serial) execution
With `gfortran` 14 or later, use
```
fpm test --profile release
```
With `gfortran` 13 or earlier, use
```
fpm test --profile release --flag "-ffree-line-length-0"
```
The above commands build the Assert library (with the default of assertion enforcement disabled) and runs the test suite.

#### Multi-image (parallel) execution
With `gfortran` 14 or later versions and OpenCoarrays installed, use
```
fpm test --compiler caf --profile release --runner "cafrun -n 2"
```
With `gfortran` 13 or earlier versions and OpenCoarrays installed,
```
fpm test --compiler caf --profile release --runner "cafrun -n 2" --flag "-ffree-line-length-0"
```

### Intel `ifx`

#### Single-image (serial) execution
```
fpm test --compiler ifx --profile release 
```

#### Multi-image (parallel) execution 
With Intel Fortran and Intel MPI installed,
```
fpm test --compiler ifx --profile release --flag "-coarray -DASSERT_MULTI_IMAGE"
```

### LLVM `flang-new`

#### Single-image (serial) execution
With `flang-new` version 19, use
```
fpm test --compiler flang-new --flag "-mmlir -allow-assumed-rank -O3"
```
With `flang-new` version 20 or later, use
```
fpm test --compiler flang-new --flag "-O3"
```

### LFortran `lfortran`

#### Single-image (serial) execution
```
fpm test --compiler lfortran --profile release --flag --cpp
```

### Numerical Algorithms Group (NAG) `nagfor`

#### Single-image (serial) execution
With `nagfor` version 7.1 or later, use
```
fpm test --compiler nagfor --flag -fpp
```

#### Multi-image execution
With `nagfor` 7.1, use
```
fpm test --compiler nagfor --profile release --flag "-fpp -coarray=cosmp -f2018"
```
With `nagfor` 7.2 or later, use
```
fpm test --compiler nagfor --flag -fpp
```

Documentation
-------------

Please see [example/README.md] and the [tests] for examples of how to use Assert.

### Potential pitfalls of `call_assert` macros:

The `call_assert*` macros from the `assert_macros.h` header file provide the
attractive guarantee that they will always compile *completely* away when
assertions are disabled, regardless of compiler analyses and optimization
level. This means users can reap the maintainability and correctness benefits
of aggressively asserting invariants throughout their code, without needing to
balance any potential performance cost associated with such assertions when the
code runs in production.

Unfortunately, preprocessor macros do not integrate cleanly with some aspects
of the Fortran language. As such, you might encounter one or more of the
following pitfalls when using these macros.

#### Line length limit

Up to and including the Fortran 2018 language standard, compilers were only
required to support up to 132 characters per free-form source line.
Preprocessor macro invocations are always expanded to a single line during
compilation, so when passing non-trivial arguments to macros including
`call_assert*` it becomes easy for the expansion to exceed this line length
limit. This can result in compile-time errors like the following from gfortran:

```
Error: Line truncated at (1) [-Werror=line-truncation]
```

Some compilers offer a command-line argument that can be used to workaround this legacy limit, e.g.,

* `gfortran -ffree-line-length-0` or equivalently `gfortran -ffree-line-length-none`

When using `fpm`, one can pass such a flag to the compiler using the `fpm --flag` option, e.g.,

```shell
$ fpm test --profile release --flag -ffree-line-length-0
```

Thankfully, Fortran 2023 raised this obsolescent line limit to 10,000
characters, so by using newer compilers you might never encounter this problem.
In the case of gfortran, this appears to have been resolved by default starting in release 14.1.0.

#### Line breaks in macro invocations

The preprocessor is not currently specified by any Fortran standard, and
as of 2025 its operation differs in subtle ways between compilers.
One way in which compilers differ is how macro invocations can safely be broken
across multiple lines.

For example, gfortran and flang-new both accept backslash `\` continuation
character for line-breaks in a macro invocation:

```fortran
! OK for flang-new and gfortran
call_assert_describe( computed_checksum == expected_checksum, \
                      "Checksum mismatch failure!" \
                    )                  
```

Whereas Cray Fortran wants `&` line continuation characters, even inside
a macro invocation:

```fortran
! OK for Cray Fortran
call_assert_describe( computed_checksum == expected_checksum, &
                      "Checksum mismatch failure!" &
                    )                  
```

There appears to be no syntax acceptable to all compilers, so when writing
portable code it's probably best to avoid line breaks inside a macro invocation.


#### Comments in macro invocations

Fortran does not support comments with an end delimiter,
only to-end-of-line comments.  As such, there is no portable way to safely insert a
Fortran comment into the middle of a macro invocation.  For example, the
following seemingly reasonable code results in a syntax error
after macro expansion (on gfortran and flang-new):

```fortran
! INCORRECT: cannot use Fortran comments inside macro invocation
call_assert_describe( computed_checksum == expected_checksum, ! ensured since version 3.14
                      "Checksum mismatch failure!"            ! TODO: write a better message here
                    )             
```

Depending on your compiler it *might* be possible to use a C-style block
comment (because they are often removed by the preprocessor), for example with
gfortran one can instead write the following:

```fortran
call_assert_describe( computed_checksum == expected_checksum, /* ensured since version 3.14 */ \
                      "Checksum mismatch failure!"            /* TODO: write a better message here */ \
                    )
```

However that capability might not be portable to other Fortran compilers. 
When in doubt, one can always move the comment outside the macro invocation:

```fortran
! assert a property ensured since version 3.14
call_assert_describe( computed_checksum == expected_checksum, \
                      "Checksum mismatch failure!"            \
                    ) ! TODO: write a better message above
```                      

Legal Information
-----------------
See the [LICENSE](LICENSE) file for copyright and licensing information.

[Hyperlinks]:#
[OpenCoarrays]: https://github.com/sourceryinstitute/opencoarrays
[Enforcing programming contracts]: #enforcing-programming-contracts
[Single-image execution]: #single-image-execution
[example/README.md]: ./example/README.md
[tests]: ./tests
[Fortran Package Manager]: https://github.com/fortran-lang/fpm
[OCL]: https://en.wikipedia.org/wiki/Object_Constraint_Language
[example/invoke-via-macro.F90]: ./example/invoke-via-macro.F90
[Producing output in pure procedures]: #producing-output-in-pure-procedures
[Julienne]: https://go.lbl.gov/julienne

Examples
========

This directory contains two example programs.

Simple examples
---------------

The [simple_assertions.f90] example demonstrates a precondition and a
postcondition, each with an assertion that checks the truth of a logical
expression based on scalar, real values.

Derived type diagnostic data
----------------------------

See [derived_type_diagnostic.f90].  For reasons related to runtime performance,
it is desirable to ensure that any computation required to extract diagnostic
data from an object only take place if the assertion fails.  This is one of the
main motivations for allowing objects to be passed to the `diagnostic_data`
argument of `assert`.  The generic programming facilities planned for
"Fortran 202y" (two standards after Fortran 2018) will ultimately provide the
best way to facilitate the extraction of diagnostic data from objects by
empowering developers to express requirements on types such as that the types
must support a specific procedure binding that can be used to extract output
in character form, the form that `assert` uses for its error stop code.  For
now, we impose such a requirement through an `as_character` deferred binding
on the provided `characterizable_t` abstract type.

Because it might prove problematic to require that a user type to extend the
`characterizable_t` abstract type, the [derived_type_diagnostic.f90] example
shows a workaround based on the class hierarchy described in the figure below.
The figure shows a Unified Modeling Language ([UML]) class diagram with the
`characterizable_t` abstract class, an example user's `stuff_t` class, and a
`characterizable_stuff_t` class.  The pattern expressed in the workaround
aggregates the example user type, `stuff_t`, as a component inside the
encapsulating `characterizable_stuff_t` type defined to extend `characterizable_t`
for purposes of implementing `characterizable_t` parent type's deferred
`as_character()` binding.

The figure below also shows two constraints written in UML's Object Constraint
Language ([OCL]).  The constraints describe the precondition and postcondition
checked in [derived_type_diagnostic.f90] and the context for those constraints.

The UML diagram below was generated in the [Atom] editor [PlantUML] package
from the PlantUML script in this repository's [doc] folder.

![Classes involved in Derived-Type Diagnostic Example](https://user-images.githubusercontent.com/13108868/130385757-6b79e5f1-5dec-440c-98f5-0f659c538754.png)

Running the examples
--------------------

### Single-image execution
```
fpm run --example simple_assertions
fpm run --example derived_type_diagnostic
```
where `fpm run` automatically invokes `fpm build` if necessary, .e.g., if the package's source code
has changed since the most recent build.  If `assert` is working correctly, the first `fpm run` above
will error-terminate with the character stop code
```
Assertion "reciprocal: abs(error) < tolerance" failed on image 1 with diagnostic data "-1.00000000"
```
and the second `fpm run` above will error-terminate with the character stop code
```
Assertion "stuff_t%z(): self%defined()" failed on image 1 with diagnostic data "(none provided)"
```

### Multi-image execution with `gfortran` and OpenCoarrays
```
git clone git@github.com/sourceryinstitute/assert
cd assert
fpm run --compiler caf --runner "cafrun -n 2" --example simple_assertions
fpm run --compiler caf --runner "cafrun -n 2" --example derived_type_diagnostic
```
Replace either instance of `2` above with the desired number of images to run for parallel execution.
If `assert` is working correctly, both of the latter `fpm run` commands will error-terminate with one
or more images providing stop codes analogous to those quoted in the [Single-image execution] section.

## Derived-type diagnostic data output
To demonstrate the derived-type diagnostic data output capability, try replacing the
`i%defined()` assertion in the [derived_type_diagnostic.f90](./derived_type_diagnostic.f90)
with `.false.`.

[Hyperlinks]:#
[OpenCoarrays]: https://github.com/sourceryinstitute/opencoarrays
[Enforcing programming contracts]: #enforcing-programming-contracts
[Single-image execution]: #single-image-execution
[derived_type_diagnostic.f90]: ./derived_type_diagnostic.f90
[simple_assertions.f90]: ./simple_assertions.f90
[UML]: https://en.wikipedia.org/wiki/Unified_Modeling_Language
[OCL]: https://en.wikipedia.org/wiki/Object_Constraint_Language
[Atom]: https://atom.io
[PlantUML]: https://plantuml.com
[doc]: ../doc/

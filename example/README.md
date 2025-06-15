Examples
========

This directory contains two example programs.

Simple examples
---------------

The [simple_assertions.f90] example demonstrates a precondition and a
postcondition, each with an assertion that checks the truth of a logical
expression based on scalar, real values.

Running the examples
--------------------

### Single-image execution
```
fpm run --example simple_assertions
```
where `fpm run` automatically invokes `fpm build` if necessary, .e.g., if the package's source code
has changed since the most recent build.  If `assert` is working correctly, the `fpm run` above
will error-terminate with the character stop code similar to the following
```
Assertion failure on image 1: reciprocal: abs(error) < tolerance
```

### Multi-image execution with `gfortran` and OpenCoarrays
```
git clone git@github.com/sourceryinstitute/assert
cd assert
fpm run --compiler caf --runner "cafrun -n 2" --example simple_assertions
```
Replace either instance of `2` above with the desired number of images to run for parallel execution.
If `assert` is working correctly, both of the latter `fpm run` commands will error-terminate with one
or more images providing stop codes analogous to those quoted in the [Single-image execution] section.

[Hyperlinks]:#
[OpenCoarrays]: https://github.com/sourceryinstitute/opencoarrays
[Enforcing programming contracts]: #enforcing-programming-contracts
[Single-image execution]: #single-image-execution
[simple_assertions.f90]: ./simple_assertions.f90
[UML]: https://en.wikipedia.org/wiki/Unified_Modeling_Language
[OCL]: https://en.wikipedia.org/wiki/Object_Constraint_Language
[Atom]: https://atom.io
[PlantUML]: https://plantuml.com
[doc]: ../doc/
